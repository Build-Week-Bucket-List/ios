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
    
    var login = false
    
    @IBOutlet weak var signupButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupButton.layer.cornerRadius = signupButton.frame.height / 2
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
    }
   
    @IBAction func segControlAction(_ sender: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            signupButton.setTitle("Sign Up", for: .normal)
        case 1:
            signupButton.setTitle("Login", for: .normal)
        default:
            break
        }
    }
    
    }
        // Do any additional setup after loading the view.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

