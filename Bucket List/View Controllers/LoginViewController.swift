//
//  LoginViewController.swift
//  Bucket List
//
//  Created by Lambda_School_Loaner_167 on 8/27/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setPadding(){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setBottomBorder(){
        
        
        self.layer.shadowColor = UIColor.eveningSea.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
    }
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var welcomeToBucketListLabel: UILabel!
    @IBOutlet var signupView: UIView!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var signupButton: UIButton!

	let layer = CAGradientLayer()
	let buttonLayer = CAGradientLayer()
	let userController = UserController.shared
	var isLogin: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupButton.layer.cornerRadius = signupButton.frame.height / 2
		signupButton.backgroundColor = UIColor.eveningSea
        
        welcomeToBucketListLabel.textColor = UIColor.eveningSea
       
		setUI()
        usernameTextfield.setPadding()
        passwordTextfield.setPadding()
        usernameTextfield.setBottomBorder()
        passwordTextfield.setBottomBorder()
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
		if isLogin {
			logIn()
            self.signupButton.backgroundColor = UIColor.eveningSea
		} else {
			signUp()
            self.signupButton.backgroundColor = UIColor.lochmara
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

	private func setUI() {
		segControl.tintColor = UIColor(red: 0.18, green: 0.41, blue: 0.30, alpha: 1.00)
		signupButton.clipsToBounds = true
		buttonLayer.startPoint = CGPoint(x: 0, y: 0.5)
		buttonLayer.endPoint = CGPoint(x: 1, y: 0.5)
		buttonLayer.frame = CGRect(x: 0, y: 0, width: signupButton.bounds.width, height: signupButton.bounds.height)
		buttonLayer.colors = [UIColor(red: 0.17, green: 0.45, blue: 0.63, alpha: 1.00).cgColor,
						UIColor(red: 0.18, green: 0.41, blue: 0.30, alpha: 1.00).cgColor]
		signupButton.layer.addSublayer(buttonLayer)
		layer.frame = view.bounds
		layer.colors = [UIColor(red: 0.98, green: 0.97, blue: 0.93, alpha: 1.00).cgColor,
						UIColor(red: 0.17, green: 0.45, blue: 0.63, alpha: 1.00).cgColor]
		view.layer.insertSublayer(layer, at: 0)
	}

}


