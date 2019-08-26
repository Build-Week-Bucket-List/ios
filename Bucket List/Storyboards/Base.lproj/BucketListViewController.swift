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

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                /*
                 bucketListDetailVC.userData = TODO
                 */
                
            }
        }
    }

}
