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
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var selectedDateLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    var item: ItemController? /* { // TODO - Change type to single item
     didSet {
     updateViews
     }
     }
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColors()
        
        setTextViewBorder(textView: notesTextView)
        setTextViewBorder(textView: descTextView)
    }
    
    private func setColors() {
        tabBarController?.tabBar.tintColor = UIColor.twilightBlue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
        
        view.backgroundColor = .lochmara
        
        nameTextField.backgroundColor = .lochmara
        descTextView.backgroundColor = .lochmara
        notesTextView.backgroundColor = .lochmara
        
        nameLabel.textColor = .twilightBlue
        descriptionLabel.textColor = .twilightBlue
        notesLabel.textColor = .twilightBlue
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
        if let title = nameTextField.text, let desc = descTextView,
            let notes = notesTextView, let date = date {
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
