//
//  Journal+Convenience.swift
//  Bucket List
//
//  Created by Marlon Raskin on 8/28/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation
import CoreData

extension Journal {
	@discardableResult convenience init(entry: String, identifier: Int64, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

		self.init(context: context)

		self.entry = entry
		self.journalentryid = identifier
	}

	@discardableResult convenience init(journalRepresentation: JournalRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

		self.init(context: context)

		let id = journalRepresentation.journalId

		self.entry = entry
		self.journalentryid = Int64(id)
	}

	var journalRepresentation: JournalRepresentation {
		return JournalRepresentation(entry: entry, journalId: Int(journalentryid))
	}
}
