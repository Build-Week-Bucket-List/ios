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
	case noAuth
}

enum LoginType: String {
	case signUp = "signup"
	case signIn = "login"
}

class UserController {

	var token: String?
	var user: UserRepresentation?

	static let shared = UserController()

	let baseURL = URL(string: "http://hypedupharris-bucketlist.herokuapp.com/")!

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
				response.statusCode != 201 {
				print(response.statusCode)
				completion(.badResponse)
				return
			}

			if error != nil {
				completion(.otherError)
				return
			}

			guard let data = data else {
				completion(.badData)
				return
			}

			do {
				self.user = try JSONDecoder().decode(UserRepresentation.self, from: data)
				let context = CoreDataStack.shared.mainContext
				context.performAndWait {
					User(userRepresentation: self.user!)
				}
				try CoreDataStack.shared.save()
			} catch {
				completion(.noDecode)
			}
			completion(nil)
		}.resume()
	}


	func logIn(user: UserRepresentation, loginType: LoginType, completion: @escaping(Result<String, NetworkError>) -> Void) {
		let requestURL = baseURL.appendingPathComponent("\(loginType.rawValue)")
		var request = URLRequest(url: requestURL)
		request.httpMethod = HTTPMethod.post.rawValue
		request.setValue("basic bGFtYmRhLWNsaWVudDpsYW1iZGEtc2VjcmV0", forHTTPHeaderField: "Authorization")
		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

		guard let username = user.username,
			let password = user.password else {
				print("Username and Password don't exist")
				completion(.failure(.noAuth))
				return
			}

		var urlComponents = URLComponents()
		let grantTypeQuery = URLQueryItem(name: "grant_type", value: "password")
		let usernameQuery = URLQueryItem(name: "username", value: "\(username)")
		let passwordQuery = URLQueryItem(name: "password", value: "\(password)")
		urlComponents.queryItems = [grantTypeQuery, usernameQuery, passwordQuery]

		var componentString = urlComponents.string
		componentString?.removeFirst()

		request.httpBody = componentString?.data(using: .utf8)

		let jsonEncoder = JSONEncoder()
		do {
			let userData = try jsonEncoder.encode(user)
			request.httpBody = userData
		} catch {
			NSLog("Error encoding userData: \(error)")
		}

		URLSession.shared.dataTask(with: request) { (data, response, error) in
			if let response = response as? HTTPURLResponse,
				response.statusCode != 200 {
				NSLog("Response status code is not 200. Status code: \(response.statusCode)")
			}

			if let error = error {
				NSLog("Error verifying user: \(error)")
				completion(.failure(.noAuth))
				return
			}

			guard let data = data else {
				NSLog("No data returned from data task")
				completion(.failure(.badData))
				return
			}

			let jsonDecoder = JSONDecoder()
			do {
				let result = try jsonDecoder.decode(UserResult.self, from: data)
				self.token = result.token
				self.user = user
				let context = CoreDataStack.shared.mainContext

				context.performAndWait {
					User(userRepresentation: self.user!)
				}

				try CoreDataStack.shared.save()
				if let token = self.token {
					KeychainWrapper.standard.set(token, forKey: "access_token")
					completion(.success(token))
				}
			} catch {
				NSLog("Error decoding data/token: \(error)")
				completion(.failure(.noDecode))
				return
			}
		}.resume()
	}
}
