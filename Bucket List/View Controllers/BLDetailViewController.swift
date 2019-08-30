//
//  BucketListDetailViewController.swift
//  Bucket List
//
//  Created by Jordan Christensen on 8/27/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit
import CoreData

class BucketListDetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

	var itemController: ItemController?
	var item: Item? {
		didSet {
			updateViews()
		}
	}

	@IBOutlet weak var itemNameTextField: UITextField!
	@IBOutlet weak var itemDescriptionTextView: UITextView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
	@IBOutlet weak var smallDateLabel: UILabel!


	override func viewDidLoad() {
		super.viewDidLoad()
		itemNameTextField.delegate = self
		itemDescriptionTextView.delegate = self
		setColors()
		setTextViewBorder(textView: itemDescriptionTextView)
		updateViews()
	}

	private func setColors() {
        let icon = UIBarButtonItem(
            image: UIImage(named: "Icon.png")?.withRenderingMode(.alwaysOriginal),
            style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = icon
        
		tabBarController?.tabBar.tintColor = UIColor.twilightBlue
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
		navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
        
        saveButton.setTitleColor(UIColor.twilightBlue, for: .normal)
        saveButton.backgroundColor = .eveningSea
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
        
        navigationController?.navigationBar.tintColor = UIColor.twilightBlue;

		view.backgroundColor = .lochmara

		itemNameTextField.backgroundColor = .lochmara
		itemDescriptionTextView.backgroundColor = .lochmara

		nameLabel.textColor = .twilightBlue
		descriptionLabel.textColor = .twilightBlue
	}

	private func setTextViewBorder(textView: UITextView) {
// 		Set UITextView border to look like a UITextField
		textView.layer.borderWidth = 0.5
		textView.layer.borderColor = UIColor.borderColor.cgColor
		textView.layer.cornerRadius = 8
	}

	private func updateViews() {
		guard let item = item,
		isViewLoaded else { return }
		itemDescriptionTextView.text = item.itemdesc
		itemNameTextField.text = item.itemtitle
		smallDateLabel.text = "Date created: \(dateFormatter.string(from: item.created ?? Date()))"
	}

	var dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		formatter.dateFormat = "mm/dd"
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

	// MARK: - Navigation
    /*
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	}
    */
}
