//
//  CompletedDetailViewController.swift
//  Bucket List
//
//  Created by Jordan Christensen on 8/29/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class CompletedDetailViewController: UIViewController, DatePickerDelegate {
    
    var date: Date?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var selectedDateLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var reselectDateButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    
    var item: ItemController? /* { // TODO - Change type to single item
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
        tabBarController?.tabBar.tintColor = UIColor.twilightBlue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
        
        self.navigationController?.navigationBar.tintColor = UIColor.twilightBlue;

        
        reselectDateButton.setTitleColor(UIColor.twilightBlue, for: .normal)
        reselectDateButton.backgroundColor = UIColor.eveningSea
        reselectDateButton.layer.cornerRadius = reselectDateButton.frame.height / 2
        
        updateButton.setTitleColor(UIColor.twilightBlue, for: .normal)
        updateButton.backgroundColor = UIColor.eveningSea
        updateButton.layer.cornerRadius = updateButton.frame.height / 2
        
        view.backgroundColor = .lochmara
        
        nameTextField.backgroundColor = .lochmara
        descTextView.backgroundColor = .lochmara
        
        nameLabel.textColor = .twilightBlue
        descriptionLabel.textColor = .twilightBlue
        selectedDateLabel.textColor = .twilightBlue
    }
    
    private func setTextViewBorder(textView: UITextView) {
        // Set UITextView border to look like a UITextField
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.borderColor.cgColor
        textView.layer.cornerRadius = 8
    }
    
    private func updateViews() {
        // Uncomment when implemented - TODO
        //        guard let item = item, let date = date else { return }
        //        itemDescriptionLabel.text = item.description
        //        dateLabel.text = dateFormatter.string(for: date)
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
        if let _ = nameTextField.text, let _ = descTextView,
            let _ = date {
            //            item.title = title
            //            item.description = description
            //            item.date = date
            return true
        }
        return false
    }

    func itemDateWasChosen(selectedDate: Date) {
        date = selectedDate
        selectedDateLabel.text = dateFormatter.string(for: selectedDate)
        date = selectedDate
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReselectDateModalSegue" {
            if let datePickerVC = segue.destination as? SelectDateViewController {
                datePickerVC.delegate = self
            }
        }
    }
    
}
