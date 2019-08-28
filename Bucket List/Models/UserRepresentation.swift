//
//  UserRepresentation.swift
//  Bucket List
//
//  Created by Marlon Raskin on 8/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation

struct UserResult: Codable {
	var token: String

	enum CodingKeys: String, CodingKey {
		case token = "access_token"
	}
}

struct UserRepresentation: Codable {
//	let name: String?
	let username: String?
	let password: String?
	let identifier: Int?

	enum CodingKeys: String, CodingKey {
//		case name
		case username
		case password
		case identifier = "userid"
	}
}

//struct UserRepresentations: Codable {
//	let results: [UserRepresentation]
//}

extension UserRepresentation: Equatable {
	static func ==(lhs: UserRepresentation, rhs: User) -> Bool {
		return lhs.identifier == Int(rhs.userid)
//			lhs.name == rhs.name &&
//			lhs.username == rhs.username
	}

	static func ==(lhs: User, rhs: UserRepresentation) -> Bool {
		return rhs == lhs
	}

	static func !=(lhs: UserRepresentation, rhs: User) -> Bool {
		return !(lhs == rhs)
	}

	static func !=(lhs: User, rhs: UserRepresentation) -> Bool {
		return rhs != lhs
	}
}
