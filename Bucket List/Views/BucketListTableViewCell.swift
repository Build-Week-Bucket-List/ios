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

    override func awakeFromNib() {
        super.awakeFromNib()
		updateViews()
//		cell.textLabel?.text = "Cell \(indexPath.row + 1)"
//		cell.detailTextLabel?.text = "The description of cell number \(indexPath.row + 1)"
//

    }

	private func updateViews() {
		
	}

	private func setUI() {
//		self.accessoryType = .disclosureIndicator
//		cell.textLabel?.textColor = .twilightBlue
//		cell.detailTextLabel?.textColor = .twilightBlue
//		cell.backgroundColor = .lochmara
	}

}
