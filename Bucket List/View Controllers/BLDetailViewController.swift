//
//  BucketListDetailViewController.swift
//  Bucket List
//
//  Created by Jordan Christensen on 8/27/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit
import CoreData

class BucketListDetailViewController: UIViewController, DatePickerDelegate, UITextFieldDelegate, UITextViewDelegate {

	var date: Date?
	var itemController: ItemController?
	var item: Item? {
		didSet {
			updateViews()
		}
	}

	@IBOutlet weak var itemNameTextField: UITextField!
	@IBOutlet weak var itemDescriptionTextView: UITextView!
	@IBOutlet weak var selectedDateLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var selectDateButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    

	override func viewDidLoad() {
		super.viewDidLoad()
		itemNameTextField.delegate = self
		itemDescriptionTextView.delegate = self
		setColors()
		selectedDateLabel.isHidden = true
		setTextViewBorder(textView: itemDescriptionTextView)
	}

	private func setColors() {
		tabBarController?.tabBar.tintColor = UIColor.twilightBlue
		self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
		self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
        
        selectDateButton.setTitleColor(UIColor.twilightBlue, for: .normal)
        selectDateButton.backgroundColor = .eveningSea
        selectDateButton.layer.cornerRadius = selectDateButton.frame.height / 2
        
        saveButton.setTitleColor(UIColor.twilightBlue, for: .normal)
        saveButton.backgroundColor = .eveningSea
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
        
        self.navigationController?.navigationBar.tintColor = UIColor.twilightBlue;

		view.backgroundColor = .lochmara

		itemNameTextField.backgroundColor = .lochmara
		itemDescriptionTextView.backgroundColor = .lochmara

		nameLabel.textColor = .twilightBlue
		descriptionLabel.textColor = .twilightBlue
	}

	private func setTextViewBorder(textView: UITextView) {
		let borderColor = UIColor(displayP3Red: 0.2, green: 0.2, blue: 0.2, alpha: 0.3)

// 		Set UITextView border to look like a UITextField
		textView.layer.borderWidth = 0.5
		textView.layer.borderColor = borderColor.cgColor
		textView.layer.cornerRadius = 8
	}

	private func updateViews() {
		guard let item = item else { return }
		itemDescriptionTextView.text = item.description
		selectedDateLabel.text = dateFormatter.string(from: item.created ?? Date())
		itemNameTextField.text = item.itemtitle
	}

	var dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		return formatter
	}()

	@IBAction func saveTapped(_ sender: UIButton) {
		guard let itemController = itemController,
			let title = itemNameTextField.text,
			!title.isEmpty,
			let description = itemDescriptionTextView.text,
			!description.isEmpty else { return }

		itemController.createItem(title: title, description: description)
		self.navigationController?.popToRootViewController(animated: true)
	}

	@IBAction func tapToDismissKeyboard(_ sender: UITapGestureRecognizer) {
		itemNameTextField.resignFirstResponder()
		itemDescriptionTextView.resignFirstResponder()
	}


	func itemDateWasChosen(selectedDate: Date) {
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
