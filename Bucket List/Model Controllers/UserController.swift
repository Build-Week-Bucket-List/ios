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
	case signUp = "signup"
	case signIn = "login"
}

class UserController {

	var token: String?
	var user: UserRepresentation?

	let baseURL = URL(string: "hypedupharris-bucketlist.herokuapp.com/")!

	func signUp(user: UserRepresentation, loginType: LoginType, completion: @escaping(NetworkError?) -> Void) {
		let requestURL = baseURL.appendingPathComponent("\(loginType.rawValue)")
		var request = URLRequest(url: requestURL)
		request.httpMethod = HTTPMethod.post.rawValue
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")

		let jsonEncoder = JSONEncoder()
		do {
			request.httpBody = try jsonEncoder.encode(user)
		} catch {
			print("Error encoding user: \(error)")
			completion(.noEncode)
			return
		}

		URLSession.shared.dataTask(with: request) { (data, response, error) in
			if let response = response as? HTTPURLResponse,
				response.statusCode != 200 {
				print(response.statusCode)
				completion(.badResponse)
				return
			}

			if error != nil {
				completion(.otherError)
				return
			}
			completion(nil)
		}.resume()
	}
}
