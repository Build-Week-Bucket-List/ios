//
//  JournalRepresentation.swift
//  Bucket List
//
//  Created by Marlon Raskin on 8/28/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation

struct JournalRepresentation: Codable {
	var entry: String?
	var journalId: Int

	enum CodingKeys: String, CodingKey {
		case entry
		case journalId = "journalentryid"
	}
}

extension JournalRepresentation: Equatable {
	static func ==(lhs: JournalRepresentation, rhs: Journal) -> Bool {
		return lhs.journalId == Int(rhs.journalentryid) &&
			lhs.entry == rhs.entry
	}

	static func ==(lhs: Journal, rhs: JournalRepresentation) -> Bool {
		return rhs == lhs
	}

	static func !=(lhs: JournalRepresentation, rhs: Journal) -> Bool {
		return !(lhs == rhs)
	}

	static func !=(lhs: Journal, rhs: JournalRepresentation) -> Bool {
		return rhs != lhs
	}
}
