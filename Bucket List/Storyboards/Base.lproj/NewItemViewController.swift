//
//  NewItemViewController.swift
//  Bucket List
//
//  Created by Jordan Christensen on 8/27/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController {

    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemDescriptionTextField: UITextField!
    @IBOutlet weak var itemNotesTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set UITextViews border to look like a UITextField
        itemNotesTextView.layer.borderWidth = 0.5
        itemNotesTextView.layer.borderColor = UIColor(displayP3Red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor
        itemNotesTextView.layer.cornerRadius = 8
    }
    
    @IBAction func createTapped(_ sender: Any) {
        // TODO - Implement createNewItem
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
