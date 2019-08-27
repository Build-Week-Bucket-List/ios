//
//  BLDetailViewController.swift
//  Bucket List
//
//  Created by Jordan Christensen on 8/27/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class BucketListDetailViewController: UIViewController {

	
    
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemNotesTextView: UITextView!
    
    /* Uncomment when implemented - TODO
     var userData: userData? {
        didSet {
            updateViews
        }
     }
	*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    private func updateViews() {
        // Uncomment when implemented - TODO
//        guard let userData = userData else { return }
//        itemDescriptionLabel.text = userData.itemDescription
//        itemNotesTextView.text = userData.itemNotes
        
    }

	var dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		return formatter
	}()
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
