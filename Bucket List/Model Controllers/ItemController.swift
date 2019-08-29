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

	init() {

	}

	static let shared = ItemController()

	let baseURL = URL(string: "http://hypedupharris-bucketlist.herokuapp.com")!

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

//	func updateItem(item: Item, title: String, description: String, isCompleted: Bool = false) {
//		CoreDataStack.shared.mainContext.performAndWait {
//			let itemRep = item.itemRepresetation
//
//		}
//	}

	func post(itemRep inputItemRepresentation: ItemRepresentation, completion: @escaping (Result<ItemRepresentation, NetworkError>) -> Void = { _ in }) {
		let createURL = baseURL.appendingPathComponent("list").appendingPathComponent("item")
		var request = URLRequest(url: createURL)
		request.httpMethod = HTTPMethod.post.rawValue
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		guard let token = KeychainWrapper.standard.string(forKey: "access_token") else {
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

	func putUpdate(itemRepresentation: ItemRepresentation, completion: @escaping (Result<Data?, NetworkError>) -> Void = { _ in }) {
		guard let identifier = itemRepresentation.identifier else { return }
		let updateRequestURL = baseURL.appendingPathComponent("list").appendingPathComponent("item").appendingPathComponent("\(identifier)")
		var request = URLRequest(url: updateRequestURL)
		request.httpMethod = HTTPMethod.put.rawValue
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		guard let token = KeychainWrapper.standard.string(forKey: "access_token") else {
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

//	func fetchAllItems(user: UserRepresentation, completion: @escaping(Error?) -> Void) {
//
//		let jsonDecoder = JSONDecoder()
//
//		do {
//			let dict = try jsonDecoder.decode([String: [ItemRepresentation]?].self, from: data)
//			guard let itemArray = dict["items"] else {
//				completion(error)
//				return
//			}
//		} catch {
//			<#Log and deal with errors#>
//		}
//	}
}

