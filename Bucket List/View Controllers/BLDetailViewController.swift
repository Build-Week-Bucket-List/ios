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

	@IBOutlet weak var itemNameTextField: UITextField!
	@IBOutlet weak var itemDescriptionTextView: UITextView!
	@IBOutlet weak var itemNotesTextView: UITextView!
	@IBOutlet weak var selectedDateLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var notesLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
		itemNameTextField.delegate = self
		itemDescriptionTextView.delegate = self
		itemNotesTextView.delegate = self
		setColors()
		selectedDateLabel.isHidden = true
		setTextViewBorder(textView: itemNotesTextView)
		setTextViewBorder(textView: itemDescriptionTextView)
	}

	private func setColors() {
		tabBarController?.tabBar.tintColor = UIColor.twilightBlue
		self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
		self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]

		view.backgroundColor = .lochmara

		itemNameTextField.backgroundColor = .lochmara
		itemDescriptionTextView.backgroundColor = .lochmara
		itemNotesTextView.backgroundColor = .lochmara

		nameLabel.textColor = .twilightBlue
		descriptionLabel.textColor = .twilightBlue
		notesLabel.textColor = .twilightBlue
	}

	private func setTextViewBorder(textView: UITextView) {
		let borderColor = UIColor(displayP3Red: 0.2, green: 0.2, blue: 0.2, alpha: 0.3)

// 		Set UITextView border to look like a UITextField
		textView.layer.borderWidth = 0.5
		textView.layer.borderColor = borderColor.cgColor
		textView.layer.cornerRadius = 8
	}

	private func updateViews() {
//		Uncomment when implemented - TODO
//		guard let item = item else { return }
//		itemDescriptionLabel.text = item.description
//		itemNotesTextView.text = item.notes


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

		itemController.createItem(title: title, description: description, date: nil, userID: nil)
		self.navigationController?.popToRootViewController(animated: true)
	}

	@IBAction func tapToDismissKeyboard(_ sender: UITapGestureRecognizer) {
		itemNameTextField.resignFirstResponder()
		itemDescriptionTextView.resignFirstResponder()
		itemNotesTextView.resignFirstResponder()
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
