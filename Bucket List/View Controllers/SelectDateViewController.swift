//
//  SelectDateViewController.swift
//  Bucket List
//
//  Created by Jordan Christensen on 8/28/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

protocol DatePickerDelegate {
	func itemDateWasChosen(selectedDate: Date)
}

class SelectDateViewController: UIViewController {

	@IBOutlet weak var datePicker: UIDatePicker!
	@IBOutlet weak var titleLabel: UILabel!
	var delegate: DatePickerDelegate?

	override func viewDidLoad() {
		super.viewDidLoad()
		setColors()
	}

	private func setColors() {
		view.backgroundColor = .twilightBlue
		titleLabel.textColor = .lochmara
		datePicker.setValue(UIColor.lochmara, forKeyPath: "textColor")
	}


	@IBAction func saveTapped(_ sender: Any) {
		delegate?.itemDateWasChosen(selectedDate: datePicker.date)
		dismiss(animated: true, completion: nil)
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
