//
//  CompletedDetailViewController.swift
//  Bucket List
//
//  Created by Jordan Christensen on 8/29/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class CompletedDetailViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var smallDateLabel: UILabel!
    
    var item: Item? /* { // TODO - Change type to single item
     didSet {
     updateViews
     }
     }
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColors()
        
        setTextViewBorder(textView: descTextView)
    }
    
    private func setColors() {
        let icon = UIBarButtonItem(
            image: UIImage(named: "Icon.png")?.withRenderingMode(.alwaysOriginal),
            style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = icon
        
        tabBarController?.tabBar.tintColor = UIColor.twilightBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
        
        navigationController?.navigationBar.tintColor = UIColor.twilightBlue;
        
        updateButton.setTitleColor(UIColor.twilightBlue, for: .normal)
        updateButton.backgroundColor = UIColor.eveningSea
        updateButton.layer.cornerRadius = updateButton.frame.height / 2
        
        view.backgroundColor = .lochmara
        
        nameTextField.backgroundColor = .lochmara
        descTextView.backgroundColor = .lochmara
        
        nameLabel.textColor = .twilightBlue
        descriptionLabel.textColor = .twilightBlue
    }
    
    private func setTextViewBorder(textView: UITextView) {
        // Set UITextView border to look like a UITextField
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.borderColor.cgColor
        textView.layer.cornerRadius = 8
    }
    
    private func updateViews() {
        guard let item = item else { return }
        descTextView.text = item.description
        nameTextField.text = item.itemtitle
        smallDateLabel.text = "Date created: \(dateFormatter.string(from: item.created ?? Date()))"
    }
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    @IBAction func updateTapped(_ sender: Any) {
        let alert: UIAlertController
        if (updateItem()) {
            alert = UIAlertController(title: "Updated Successfully", message: "The information has successfully been changed", preferredStyle: .alert)
        } else {
            alert = UIAlertController(title: "Update was Unsuccessful", message: "The information was not updated. Please try again", preferredStyle: .alert)
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tapToDismissKeyboard(_ sender: Any) {
        nameTextField.resignFirstResponder()
        descTextView.resignFirstResponder()
    }
    

    private func updateItem() -> Bool {
        if let _ = nameTextField.text, let _ = descTextView {
            //            item.title = title
            //            item.description = description
            return true
        }
        return false
    }
    
    // MARK: - Navigation
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    */
    
}
