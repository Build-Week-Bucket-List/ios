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
        bucketListItemName.text = "Cell"
        bucketListItemDescription.text = "The description of cell"
	}
    
    @IBAction func doneTapped(_ sender: UIButton) {
        
    }

	private func setUI() {
        self.accessoryType = .disclosureIndicator
        
        bucketListItemName.textColor = .twilightBlue
        bucketListItemDescription.textColor = .twilightBlue
        backgroundColor = .lochmara
        doneButton.setTitleColor(UIColor.twilightBlue, for: .normal)
        doneButton.backgroundColor = UIColor.eveningSea
	}

}
