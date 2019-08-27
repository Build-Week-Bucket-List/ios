//
//  UserController.swift
//  Bucket List
//
//  Created by Marlon Raskin on 8/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation
import CoreData

enum NetworkError: Error {
	case otherError
	case badData
	case noDecode
	case noEncode
	case badResponse
}

enum LoginType: String {
	case signUp = "register"
	case signIn = "login"
}

class UserController {
	let baseURL = URL(string: "hypedupharris-bucketlist.herokuapp.com/signup")

	
}
