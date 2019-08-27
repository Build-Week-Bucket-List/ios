//
//  User+Convenience.swift
//  Bucket List
//
//  Created by Marlon Raskin on 8/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation
import CoreData

extension User {
	@discardableResult convenience init(name: String, username: String, password: String, identifier: Int32, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

		self.init(context: context)

		self.name = name
		self.username = username
		self.password = password
		self.identifier = identifier
	}

	@discardableResult convenience init?(userRepresentation: UserRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

		self.init(context: context)

		guard let id = userRepresentation.identifier else { return nil }

		self.name = name
		self.username = username
		self.password = password
		self.identifier = Int32(id)
	}

	var userRepresentation: UserRepresentation {
		return UserRepresentation(name: name, username: username, password: password, identifier: Int(identifier))
	}
}
