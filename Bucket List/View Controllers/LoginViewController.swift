//
//  LoginViewController.swift
//  Bucket List
//
//  Created by Lambda_School_Loaner_167 on 8/27/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var signupView: UIView!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var signupButton: UIButton!

	let userController = UserController.shared
	var isLogin: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupButton.layer.cornerRadius = signupButton.frame.height / 2
    self.view.backgroundColor = UIColor.eveningSea
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
		if isLogin {
			logIn()
		} else {
			signUp()
		}
    }
   
    @IBAction func segControlAction(_ sender: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            signupButton.setTitle("Sign Up", for: .normal)
			isLogin = false
        case 1:
            signupButton.setTitle("Login", for: .normal)
			isLogin = true
        default:
            break
        }
    }

	func signUp() {
		let checker = fieldChecker()
		if checker == true {
			guard let username = usernameTextfield.text,
				!username.isEmpty,
				let password = passwordTextfield.text,
				!password.isEmpty else { return }

			let user = UserRepresentation(username: username, password: password, identifier: nil)
			userController.signUp(user: user, loginType: .signUp) { (error) in
				if let error = error {
					NSLog("Error registering with \(error)")
				}

				DispatchQueue.main.async {
					let loginAlert = UIAlertController(title: "Sign Up successful. Now please log in", message: nil, preferredStyle: .alert)
					loginAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
					self.present(loginAlert, animated: true, completion: {
						self.segControl.selectedSegmentIndex = 1
						self.signupButton.setTitle("Login", for: .normal)
						self.isLogin = true
					})
				}
			}
		}
	}

	func logIn() {
		let checker = fieldChecker()
		if checker == true {
			guard let username = usernameTextfield.text,
				!username.isEmpty,
				let password = passwordTextfield.text,
				!password.isEmpty else { return }

			let user = UserRepresentation(username: username, password: password, identifier: nil)
			userController.logIn(user: user, loginType: .signIn) { (result) in
				if (try? result.get()) != nil {
					DispatchQueue.main.async {
						self.dismiss(animated: true, completion: nil)
					}
				} else {
					return
				}
			}
		}
	}

	func fieldChecker() -> Bool {
		let title: String = "Oops!"
		var message: String?
		var checker: Bool = false

		if let username = usernameTextfield.text,
			let password = passwordTextfield.text {
			if username.isEmpty && isLogin == false {
				message = "Please enter a username"
			} else if password.isEmpty {
				message = "Please enter a password"
			} else if password.count < 5 {
				message = "Password must be at least 5 characters long"
			} else {
				checker = true
			}
		}
		if checker == false {
			let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			self.present(alert, animated: true, completion: nil)
		}

		return checker
	}

}

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

