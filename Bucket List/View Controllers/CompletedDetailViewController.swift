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
    
    @IBOutlet weak var completedNameTextField: UITextField!
    @IBOutlet weak var completedDescTextView: UITextView!
    @IBOutlet weak var completedNotesTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var item: ItemController? /* { // TODO - Change type to single item
     didSet {
     updateViews
     }
     }
     */

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextViewBorder(textView: completedNotesTextView)
        setTextViewBorder(textView: completedDescTextView)
    }
    
    private func setTextViewBorder(textView: UITextView) {
        let borderColor = UIColor(displayP3Red: 0.2, green: 0.2, blue: 0.2, alpha: 0.3)
        
        // Set UITextView border to look like a UITextField
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = borderColor.cgColor
        textView.layer.cornerRadius = 8
    }
    
    private func updateViews() {
        // Uncomment when implemented - TODO
        //        guard let item = item, let date = date else { return }
        //        itemDescriptionLabel.text = item.description
        //        itemNotesTextView.text = item.notes
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
    
    private func updateItem() -> Bool {
        if let title = completedNameTextField.text, let desc = completedDescTextView,
            let notes = completedNotesTextView, let date = date {
//            item.title = title
//            item.description = description
//            item.notes = notes
//            item.date = date
            return true
        }
        return false
    }
    
    func itemDateWasChosen(selectedDate: Date) {
        date = selectedDate
        dateLabel.text = dateFormatter.string(for: selectedDate)
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
