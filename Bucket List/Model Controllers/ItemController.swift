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

	let baseURL = URL(string: "hypedupharris-bucketlist.herokuapp.com/")!

	func createItem(title: String, notes: String?) {
		
	}
}

