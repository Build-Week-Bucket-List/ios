//
//  BucketListTableViewController.swift
//  Bucket List
//
//  Created by Marlon Raskin on 8/28/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit
import CoreData

class BucketListTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

	let itemController = ItemController()
    let token: String? = KeychainWrapper.standard.string(forKey: "access_token")
//        var user: UserRepresentation {
//            let moc = CoreDataStack.shared.mainContext
//            let request: NSFetchRequest<User> = User.fetchRequest()
//
//            do {
//                let users = try moc.fetch(request)
//                if let user = users.first {
//                    return user.userRepresentation
//                }
//            } catch {
//                fatalError("Error performing fetch for users: \(error)")
//            }
//            return UserRepresentation()
//        }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(token ?? "")")
        if UserDefaults.isFirstLaunch() && token == nil {
            performSegue(withIdentifier: "LoginModalSegue", sender: self)
        } else if token == nil {
            performSegue(withIdentifier: "LoginModalSegue", sender: self)
        }
        
        setColors()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setColors() {
        navigationController?.navigationBar.barTintColor = UIColor.eveningSea
        tabBarController?.tabBar.barTintColor = UIColor.eveningSea
        
        tabBarController?.tabBar.tintColor = UIColor.twilightBlue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
        
        tableView.backgroundColor = .lochmara
        view.backgroundColor = .lochmara
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BLDetailViewShowSegue" {
			if let detailVC = segue.destination as? BucketListDetailViewController {
//                let indexPath = tableView.indexPathForSelectedRow {
                detailVC.title = "Add New Adventure"
            }
        } else if segue.identifier == "AddNewItemShowSegue" {
            if let detailVC = segue.destination as? BucketListDetailViewController {
				detailVC.itemController = itemController
            }
        }
    }
}

extension BucketListTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BucketListCell", for: indexPath) as? BucketListTableViewCell else { return UITableViewCell() }
        
        cell.textLabel?.text = "Cell \(indexPath.row + 1)"
        cell.detailTextLabel?.text = "The description of cell number \(indexPath.row + 1)"
        
        cell.textLabel?.textColor = .twilightBlue
        cell.detailTextLabel?.textColor = .twilightBlue
        cell.backgroundColor = .lochmara
        
        return cell
    }
}

extension BucketListTableViewController: NSFetchedResultsControllerDelegate {
    
}
