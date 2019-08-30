//
//  searchFriendsTableViewCell.swift
//  Bucket List
//
//  Created by Lambda_School_Loaner_167 on 8/29/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class searchFriendsTableViewCell: UITableViewCell {
    
    

    @IBAction func addButtonTapped(_ sender: UIButton) {
    }
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var searchedFriendCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.lochmara
        searchedFriendCell.textColor = UIColor.twilightBlue
        
        addButton.backgroundColor = .lochmara
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(.twilightBlue, for: .normal)
        addButton.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
