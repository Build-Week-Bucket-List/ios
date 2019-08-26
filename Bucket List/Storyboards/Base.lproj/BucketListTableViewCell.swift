//
//  BucketListTableViewCell.swift
//  Bucket List
//
//  Created by Jordan Christensen on 8/27/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class BucketListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bucketListItemName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
