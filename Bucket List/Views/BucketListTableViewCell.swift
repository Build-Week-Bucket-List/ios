//
//  BucketListTableViewCell.swift
//  Bucket List
//
//  Created by Jordan Christensen on 8/27/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class BucketListTableViewCell: UITableViewCell {

	var item: Item? {
		didSet {
			updateViews()
		}
	}
    
    @IBOutlet weak var bucketListItemName: UILabel!
    @IBOutlet weak var bucketListItemDescription: UILabel!
    @IBOutlet weak var doneButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
		updateViews()
        setUI()

    }

	private func updateViews() {
		guard let item = item else { return }
        bucketListItemName.text = item.itemtitle
        bucketListItemDescription.text = item.itemdesc
	}
    
    @IBAction func doneTapped(_ sender: UIButton) {
        
    }

	override func prepareForReuse() {
		item = nil
	}

	private func setUI() {
        self.accessoryType = .disclosureIndicator
        
        bucketListItemName.textColor = .twilightBlue
        bucketListItemDescription.textColor = .twilightBlue
        backgroundColor = .lochmara
        doneButton.setTitleColor(UIColor(red: 0.70, green: 0.90, blue: 1.00, alpha: 1.00), for: .normal)
        doneButton.layer.borderWidth = 1.5
        doneButton.layer.cornerRadius = 6
        doneButton.layer.borderColor = UIColor(red: 0.70, green: 0.90, blue: 1.00, alpha: 1.00).cgColor
	}

}
