//
//  CompletedListViewController.swift
//  Bucket List
//
//  Created by Jordan Christensen on 8/29/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class CompletedListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var completedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColors()
        
        completedTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    private func setColors() {
        navigationController?.navigationBar.barTintColor = UIColor.eveningSea
        tabBarController?.tabBar.barTintColor = UIColor.eveningSea
        
        tabBarController?.tabBar.tintColor = UIColor.twilightBlue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
        
        completedTableView.backgroundColor = .lochmara
        view.backgroundColor = .lochmara
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedItemCell", for: indexPath)
        
        cell.textLabel?.text = "Completed Cell #\(indexPath.row + 1)"
        cell.detailTextLabel?.text = "The description of cell number \(indexPath.row + 1)"
        
        cell.textLabel?.textColor = .twilightBlue
        cell.detailTextLabel?.textColor = .twilightBlue
        cell.backgroundColor = .lochmara
        
        return cell
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
