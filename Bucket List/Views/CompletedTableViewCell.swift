//
//  CompletedTableViewCell.swift
//  Bucket List
//
//  Created by Jordan Christensen on 8/30/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class CompletedTableViewCell: UITableViewCell {
    
    var item: Item? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var completedItemName: UILabel!
    @IBOutlet weak var completedItemDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
        setUI()
        
    }
    
    private func updateViews() {
        completedItemName.text = "Cell"
        completedItemDescription.text = "The description of cell"
    }
    
    private func setUI() {
        self.accessoryType = .disclosureIndicator
        
        completedItemName.textColor = .twilightBlue
        completedItemDescription.textColor = .twilightBlue
        backgroundColor = .lochmara
    }


}
