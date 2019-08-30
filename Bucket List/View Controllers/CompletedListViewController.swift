//
//  CompletedListViewController.swift
//  Bucket List
//
//  Created by Jordan Christensen on 8/29/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit
import CoreData

class CompletedListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var completedTableView: UITableView!

	lazy var fetchedResultsController: NSFetchedResultsController<Item> = {
		let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()

//		let titleDescriptor = NSSortDescriptor(key: "itemtitle", ascending: true)
		let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
		fetchRequest.sortDescriptors = [completedDescriptor]

		let moc = CoreDataStack.shared.mainContext
		let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)

		frc.delegate = self
		do {
			try frc.performFetch()
		} catch {
			fatalError("Error performing fetch for frc: \(error)")
		}
		return frc
	}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColors()
        
        completedTableView.dataSource = self
		completedTableView.tableFooterView = UIView()
        
        // Do any additional setup after loading the view.
    }

//	@objc func beginRefresh() {
//		entryController.fetchEntriesFromServer { (_) in
//			DispatchQueue.main.async {
//				self.tableView.refreshControl?.endRefreshing()
//			}
//		}
//	}

    private func setColors() {
        let icon = UIBarButtonItem(
            image: UIImage(named: "Icon.png")?.withRenderingMode(.alwaysOriginal),
            style: .plain, target: self, action: #selector(addNewItem))
        navigationItem.rightBarButtonItem = icon
        
        navigationController?.navigationBar.barTintColor = UIColor.eveningSea
        tabBarController?.tabBar.barTintColor = UIColor.eveningSea
        
        tabBarController?.tabBar.tintColor = UIColor.twilightBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
        
        completedTableView.backgroundColor = .lochmara
        view.backgroundColor = .lochmara
    }
    
    @objc private func addNewItem() {
        performSegue(withIdentifier: "NewCompletedShowSegue", sender: self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedItemCell", for: indexPath) as? CompletedTableViewCell else { return UITableViewCell() }

		let item = fetchedResultsController.object(at: indexPath)
		cell.textLabel?.text = item.itemtitle
		cell.detailTextLabel?.text = item.itemdesc
        
        return cell
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewCompletedShowSegue" {
            guard let newCompletedDetailVC = segue.destination as? CompletedDetailViewController else { return }
            newCompletedDetailVC.title = "Add Completed Item"
            // newCompletedDetailVC.item = ItemController.
        }
     }
}

extension CompletedListViewController: NSFetchedResultsControllerDelegate {

}
