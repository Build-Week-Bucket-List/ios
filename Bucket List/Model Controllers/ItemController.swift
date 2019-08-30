//
//  ItemController.swift
//  Bucket List
//
//  Created by Marlon Raskin on 8/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation
import CoreData

enum HTTPMethod: String {
	case get = "GET"
	case put = "PUT"
	case post = "POST"
	case delete = "DELETE"
}

class ItemController {

	static let shared = ItemController()

	let baseURL = URL(string: "http://hypedupharris-bucketlist.herokuapp.com")!

	// MARK: - CoreData Functions
	func createItem(title: String, description: String) {
		let item = ItemRepresentation(itemTitle: title, itemDescription: description, date: nil, identifier: nil, isCompleted: nil, journal: nil)
		post(itemRep: item, completion: { (result) in
			do {
				let serverItemRep = try result.get()
				let backgroundContext = CoreDataStack.shared.container.newBackgroundContext()
				Item(itemRepresentation: serverItemRep, context: backgroundContext)
				try CoreDataStack.shared.save(context: backgroundContext)
			} catch {
				NSLog("Error creating item on server: \(error)")
			}
		})
	}

	func updateItem(item: Item, title: String, description: String, isCompleted: Bool = false) {
		CoreDataStack.shared.mainContext.performAndWait {
			let itemRep = item.itemRepresetation
			putUpdate(itemRepresentation: itemRep)

			item.itemtitle = title
			item.itemdesc = description
			item.completed = isCompleted

			do {
				try CoreDataStack.shared.save()
			} catch {
				NSLog("Error saving context when updating item: \(error)")
			}
		}
	}

	func deleteItem(item: Item, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
		context.performAndWait {
			deleteItemFromServer(item: item)
			let moc = CoreDataStack.shared.mainContext
			moc.delete(item)
			do {
				try CoreDataStack.shared.save(context: context)
			} catch {
				NSLog("Error saving context when deleting item: \(error)")
			}
		}
	}


	// MARK: - Server Functions
	private func post(itemRep inputItemRepresentation: ItemRepresentation, completion: @escaping (Result<ItemRepresentation, NetworkError>) -> Void = { _ in }) {
		let createURL = baseURL.appendingPathComponent("list").appendingPathComponent("item")
		var request = URLRequest(url: createURL)
		request.httpMethod = HTTPMethod.post.rawValue
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		guard let token = KeychainWrapper.standard.string(forKey: .accessTokenKey) else {
			print("User not logged in.")
			completion(.failure(.noAuth))
			return
		}
		request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

		do {
			let jsonEncoder = JSONEncoder()
			request.httpBody = try jsonEncoder.encode(inputItemRepresentation)
		} catch {
			NSLog("Error encoding \(inputItemRepresentation): \(error)")
			completion(.failure(.noEncode))
			return
		}

		URLSession.shared.dataTask(with: request) { (data, response, error) in

			if let error = error {
				NSLog("Error POSTing item to server: \(error)")
				completion(.failure(.otherError))
				return
			}

			guard let response = response as? HTTPURLResponse,
				(200...299).contains (response.statusCode) else {
					completion(.failure(.badResponse))
					return
			}

			guard let data = data else { return }

			do {
				let serverItemRep = try JSONDecoder().decode(ItemRepresentation.self, from: data)
				let backgroundContext = CoreDataStack.shared.container.newBackgroundContext()
				backgroundContext.performAndWait {
					Item(itemRepresentation: serverItemRep, context: backgroundContext)
				}
				try CoreDataStack.shared.save(context: backgroundContext)
			} catch {
				NSLog("Error decoding data or saving context - item: \(data) | error: \(error)")
			}
		}.resume()
	}


	private func putUpdate(itemRepresentation: ItemRepresentation, completion: @escaping (Result<Data?, NetworkError>) -> Void = { _ in }) {
		guard let identifier = itemRepresentation.identifier else { return }
		let updateRequestURL = baseURL.appendingPathComponent("list").appendingPathComponent("item").appendingPathComponent("\(identifier)")
		var request = URLRequest(url: updateRequestURL)
		request.httpMethod = HTTPMethod.put.rawValue
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		guard let token = KeychainWrapper.standard.string(forKey: .accessTokenKey) else {
			print("User not logged in.")
			completion(.failure(.noAuth))
			return
		}
		request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

		do {
			request.httpBody = try JSONEncoder().encode(itemRepresentation)
		} catch {
			NSLog("Error encoding itemRepresentation: \(error)")
		}

		URLSession.shared.dataTask(with: request) { (_, response, error) in

			if let error = error {
				NSLog("Error PUTing item to server: \(error)")
				completion(.failure(.otherError))
				return
			}

			guard let response = response as? HTTPURLResponse,
				response.statusCode == 200 else {
					completion(.failure(.badResponse))
					return
			}
			completion(.success(nil))
		}.resume()
	}


	func fetchAllItems(completion: @escaping(Error?) -> Void = { _ in }) {
		let updateRequestURL = baseURL.appendingPathComponent("list").appendingPathComponent("user")
		var request = URLRequest(url: updateRequestURL)
		request.httpMethod = HTTPMethod.get.rawValue
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		guard let token = KeychainWrapper.standard.string(forKey: .accessTokenKey) else {
			print("User not logged in.")
			completion(nil)
			return
		}
		request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

		URLSession.shared.dataTask(with: request) { (data, response, error) in

			if let error = error {
				NSLog("Error retrieving items with userRepresentation: \(error)")
				completion(error)
				return
			}

			guard let response = response as? HTTPURLResponse,
				response.statusCode == 200 else {
					completion(NetworkError.badResponse)
					return
			}

			guard let data = data else {
				NSLog("No data returned from data task")
				return
			}


			let jsonDecoder = JSONDecoder()
			do {
				let itemWrapper = try jsonDecoder.decode(ItemWrapper.self, from: data)
				let itemArray = itemWrapper.items
				self.updateItems(with: itemArray)
				try CoreDataStack.shared.save()
			} catch {
				NSLog("Error decoding item array: \(error)")
			}
			completion(nil)
		}.resume()
	}


	private func fetchSingleItemFromPersistentStore(itemID: Int64, context: NSManagedObjectContext) -> Item? {
		let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "identifier == %@", itemID)

		var item: Item?

		context.performAndWait {
			do {
				item = try context.fetch(fetchRequest).first
			} catch {
				NSLog("Error fetching item with identifier: \(itemID). Error: \(error)")
			}
		}
		return item
	}


	private func update(item: Item, itemRepresentation: ItemRepresentation) {
		item.itemtitle = itemRepresentation.itemTitle
		item.itemdesc = itemRepresentation.itemDescription
		item.created = itemRepresentation.date
		item.completed = itemRepresentation.isCompleted ?? false
	}


	private func updateItems(with itemRepresentations: [ItemRepresentation], context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
		context.performAndWait {
			for itemRep in itemRepresentations {
				guard let identifier = itemRep.identifier else { return }
				let item = fetchSingleItemFromPersistentStore(itemID: Int64(identifier), context: context)

				if let item = item {
					if item != itemRep {
						update(item: item, itemRepresentation: itemRep)
					}
				} else {
					Item(itemRepresentation: itemRep)
				}
			}
		}
	}


	private func deleteItemFromServer(item: Item, completion: @escaping (Error?) -> Void = { _ in }) {
		let requestURL = baseURL
			.appendingPathComponent("list")
			.appendingPathComponent("item")
			.appendingPathComponent("\(item.itemid)")

		var request = URLRequest(url: requestURL)
		request.httpMethod = HTTPMethod.delete.rawValue
		guard let token = KeychainWrapper.standard.string(forKey: .accessTokenKey) else {
			print("User not logged in.")
			completion(nil)
			return
		}
		request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

		URLSession.shared.dataTask(with: request) { (_, response, error) in
			if let error = error {
				NSLog("Error deleting item from server: \(error)")
				completion(error)
				return
			}

			guard let response = response as? HTTPURLResponse,
				response.statusCode == 200 else {
					completion(error)
					return
			}
			completion(nil)
		}.resume()
	}
}

