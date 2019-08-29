//
//  searchFriendsTableViewCell.swift
//  Bucket List
//
//  Created by Lambda_School_Loaner_167 on 8/29/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class searchFriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var searchedFriendCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.lochmara
        searchedFriendCell.textColor = UIColor.twilightBlue
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
