//
//  FriendsTabTableViewController.swift
//  Bucket List
//
//  Created by Lambda_School_Loaner_167 on 8/28/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class FriendsListTabTableViewController: UITableViewController {
    
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBAction func searchButtonTApped(_ sender: UIBarButtonItem) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func setUI() {
        let icon = UIBarButtonItem(
            image: UIImage(named: "Icon.png")?.withRenderingMode(.alwaysOriginal),
            style: .plain, target: self, action: nil)
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: Selector("search"))
        navigationItem.rightBarButtonItems = [icon, search]
        
        navigationController?.navigationBar.barTintColor = UIColor.eveningSea
        tabBarController?.tabBar.barTintColor = UIColor.eveningSea
        
        tabBarController?.tabBar.tintColor = UIColor.twilightBlue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
        
        self.view.backgroundColor = UIColor.lochmara
        self.navigationController?.navigationBar.tintColor = UIColor.twilightBlue;
    }
    
    @objc private func search() {
        performSegue(withIdentifier: "searchFriendsShowSegue", sender: self)
    }

    // MARK: - Table view data source


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsListCell") as? FriendsTabTableViewCell else {
            return UITableViewCell()
        }
        // guard let user = ""

        return cell
    }

//
////     Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//         Return false if you do not want the specified item to be editable.
//        return true
//    }
//    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
