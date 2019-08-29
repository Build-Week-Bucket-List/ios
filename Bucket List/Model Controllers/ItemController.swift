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

	let baseURL = URL(string: "hypedupharris-bucketlist.herokuapp.com/list")!

	func createItem(title: String, description: String, isCompleted: Bool = false, date: Date?, userID: Int?) {
		CoreDataStack.shared.mainContext.performAndWait {
			guard let date = date,
				let userID = userID else { return }
			let item = Item(title: title, description: description, date: date, identifier: Int64(userID))
			do {
				try CoreDataStack.shared.save()
			} catch {
				NSLog("Error saving context when creating an item: \(error)")
			}
			post(item: item.itemRepresetation)
		}
	}





	func post(item: ItemRepresentation, completion: @escaping(Error?) -> Void = { _ in }) {
		let createURL = baseURL.appendingPathComponent("item")
		var request = URLRequest(url: createURL)
		request.httpMethod = HTTPMethod.post.rawValue
		request.setValue("application/json", forHTTPHeaderField: "Conttent-Type")

		do {
			let jsonEncoder = JSONEncoder()
			request.httpBody = try jsonEncoder.encode(item)
		} catch {
			NSLog("Error encoding \(item): \(error)")
			completion(error)
			return
		}

		URLSession.shared.dataTask(with: request) { (_, response, error) in
			if let error = error {
				NSLog("Error POSTing item to server: \(error)")
				completion(error)
				return
			}

//			guard let data = data else { return }

			if let response = response as? HTTPURLResponse,
				(200...299).contains (response.statusCode) {
				completion(nil)
				return
			} else {
				completion(NetworkError.badResponse)
			}
//			do {
//				let itemID = try JSONDecoder().decode([Int].self, from: data)
//				let backgroundContext = CoreDataStack.shared.container.newBackgroundContext()
//				backgroundContext.performAndWait {
//					let item = Item(itemRepresentation: item, context: backgroundContext)
//					guard let identifier = itemID.first else { return }
//					item?.itemid = Int64(identifier)
//				}
//			} catch {
//
//			}
		}.resume()
	}

	func fetchAllItems(user: UserRepresentation, completion: @escaping(Error?) -> Void) {
		
	}
}

