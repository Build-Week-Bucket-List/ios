//
//  BucketListDetailViewController.swift
//  Bucket List
//
//  Created by Jordan Christensen on 8/27/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class BucketListDetailViewController: UIViewController, DatePickerDelegate {

    var date: Date?
    
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemDescriptionTextView: UITextView!
    @IBOutlet weak var itemNotesTextView: UITextView!
    @IBOutlet weak var selectedDateLabel: UILabel!
    
    var item: ItemController? /* { // TODO - Change type to single item
        didSet {
            updateViews
        }
     }
	*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //selectedDateLabel.isHidden = true
        
        setTextViewBorder(textView: itemNotesTextView)
        setTextViewBorder(textView: itemDescriptionTextView)
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
//        guard let item = item else { return }
//        itemDescriptionLabel.text = item.description
//        itemNotesTextView.text = item.notes
        
        
    }

	var dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		return formatter
	}()
    
    @IBAction func saveTapped(_ sender: UIButton) {
        
    }
    
    func itemDateWasChosen(selectedDate: Date) {
        print(selectedDate)
        print(dateFormatter.string(for: selectedDate)!)
        date = selectedDate
        selectedDateLabel.text = dateFormatter.string(for: selectedDate)
        selectedDateLabel.isHidden = false
        date = selectedDate
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SetItemDateModalSegue" {
            if let datePickerVC = segue.destination as? SelectDateViewController {
                datePickerVC.delegate = self
            }
        }
    }
}
