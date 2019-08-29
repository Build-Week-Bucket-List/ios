//
//  Item+Convenience.swift
//  Bucket List
//
//  Created by Marlon Raskin on 8/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation
import CoreData

extension Item {
	@discardableResult convenience init(title: String, description: String, completed: Bool = false, date: Date, identifier: Int64, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

		self.init(context: context)

		self.itemtitle = title
		self.itemdesc = description
		self.completed = completed
		self.created = date
		self.itemid = identifier

	}

	@discardableResult convenience init?(itemRepresentation: ItemRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

		self.init(context: context)



		self.itemtitle = itemRepresentation.itemTitle
		self.itemdesc = itemRepresentation.itemDescription
		self.completed = itemRepresentation.isCompleted ?? false
		self.created = itemRepresentation.date
		if let identifier = itemRepresentation.identifier {
			self.itemid = Int64(identifier)
		}
	}

	var itemRepresetation: ItemRepresentation {
		return ItemRepresentation(itemTitle: itemtitle, itemDescription: itemdesc, date: created, identifier: Int(itemid), isCompleted: completed, journal: journal?.journalRepresentation)
	}
}
