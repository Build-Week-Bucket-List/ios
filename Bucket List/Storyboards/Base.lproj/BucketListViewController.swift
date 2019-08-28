//
//  BucketListViewController.swift
//  Bucket List
//
//  Created by Jordan Christensen on 8/27/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class BucketListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var bucketListTableView: UITableView!

	let token: String? = KeychainWrapper.standard.String(forKey: "token")

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(token ?? "")")
		if UserDefaults.isFirstLaunch() && token == nil {
			performSegue(withIdentifier: "LoginModalSegue", sender: self)
		} else if token == nil {
			performSegue(withIdentifier: "LoginModalSegue", sender: self)
		} else if user.identifier == nil {
			performSegue(withIdentifier: "LoginModalSegue", sender: self)
		}

        bucketListTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BucketListCell", for: indexPath) as? BucketListTableViewCell else { return UITableViewCell() }
        
        cell.bucketListItemName.text = "Cell \(indexPath.row + 1)"
        
        return cell
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BLDetailViewShowSegue" {
            if let bucketListDetailVC = segue.destination as? BucketListDetailViewController,
                let indexPath = bucketListTableView.indexPathForSelectedRow {
                bucketListDetailVC.title = "Edit Item" // TODO - Replace "Item" with \()
                bucketListDetailVC.item = itemController // TODO - Change to single item rather than itemController
                /*
                 bucketListDetailVC.userData = TODO
                 */
            }
        }
        if segue.identifier == "AddNewItemShowSegue" {
            if let bucketListDetailVC = segue.destination as? BucketListDetailViewController,
                let indexPath = bucketListTableView.indexPathForSelectedRow {
                bucketListDetailVC.title = "Add New Item"
                bucketListDetailVC.item = itemController // TODO - Change to single item rather than itemController
                /*
                 bucketListDetailVC.itemData = TODO
                 */
            }
        }
    }

}
