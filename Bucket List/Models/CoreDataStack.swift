//
//  CoreDataStack.swift
//  Bucket List
//
//  Created by Marlon Raskin on 8/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {

	private init() {}
	static let shared = CoreDataStack()

	lazy var container: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "BucketList")
		container.loadPersistentStores(completionHandler: { (_, error) in
			if let error = error {
				fatalError("Failed to load persistent store(s): \(error)")
			}
			container.viewContext.automaticallyMergesChangesFromParent = true
		})
		return container
	}()

	var mainContext: NSManagedObjectContext {
		return container.viewContext
	}

	func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) throws {
		var saveError: Error?
		context.performAndWait {
			do {
				try context.save()
			} catch {
				saveError = error
				NSLog("Error when saving: \(error)")
			}
		}
		if let saveError = saveError {
			throw saveError
		}
	}

	func removeAllObjects() {
		let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
		fetchRequest.includesPropertyValues = false
		let backgroundContext = container.newBackgroundContext()
		backgroundContext.perform {
			do {
				let items = try backgroundContext.fetch(fetchRequest)
				items.forEach { backgroundContext.delete($0) }
				try self.save(context: backgroundContext)
			} catch {
				NSLog("Error deleting entities in main context: \(error)")
			}
		}
	}
}
