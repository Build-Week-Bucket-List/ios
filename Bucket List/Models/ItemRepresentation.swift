//
//  ItemRepresentation.swift
//  Bucket List
//
//  Created by Marlon Raskin on 8/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation


struct ItemRepresentation: Codable {
	let itemTitle: String?
	let itemDescription: String?
	let date: Date?
	let identifier: Int?
	let isCompleted: Bool?
	let journal: JournalRepresentation?

	enum CodingKeys: String, CodingKey {
		case itemTitle = "itemtitle"
		case itemDescription = "itemdesc"
		case date = "created"
		case identifier = "itemid"
		case isCompleted = "completed"
		case journal
	}
}

struct ItemRepresentations: Codable {
	let results: [ItemRepresentation]
}

extension ItemRepresentation: Equatable {
	static func ==(lhs: ItemRepresentation, rhs: Item) -> Bool {
		return lhs.identifier == Int(rhs.itemid) &&
			lhs.itemTitle == rhs.itemtitle &&
			lhs.itemDescription == rhs.itemdesc &&
			lhs.date == rhs.created &&
			lhs.identifier == Int(rhs.itemid) &&
			lhs.isCompleted == rhs.completed
//			lhs.journal == rhs.journal
	}

	static func ==(lhs: Item, rhs: ItemRepresentation) -> Bool {
		return rhs == lhs
	}

	static func !=(lhs: ItemRepresentation, rhs: Item) -> Bool {
		return !(lhs == rhs)
	}

	static func !=(lhs: Item, rhs: ItemRepresentation) -> Bool {
		return rhs != lhs
	}
}
