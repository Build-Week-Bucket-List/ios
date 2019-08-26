//
//  ItemRepresentation.swift
//  Bucket List
//
//  Created by Marlon Raskin on 8/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation


struct ItemRepresentation: Codable {
	let itemTitle: String
	let itemDescription: String
	let date: Date
	let identifier: Int
	let isCompleted: Bool
	let notes: String

	enum CodingKeys: String, CodingKey {
		case itemTitle
		case itemDescription
		case date
		case identifier
		case isCompleted
		case notes
	}
}

struct ItemRepresentations: Codable {
	let results: [ItemRepresentation]
}

extension ItemRepresentation: Equatable {
	static func ==(lhs: ItemRepresentation, rhs: Item) -> Bool {
		return lhs.identifier == Int(rhs.identifier) &&
			lhs.itemTitle == rhs.itemTitle &&
			lhs.itemDescription == rhs.itemDesc &&
			lhs.date == rhs.date &&
			lhs.identifier == Int(rhs.identifier) &&
			lhs.isCompleted == rhs.completed &&
			lhs.notes == rhs.notes
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
