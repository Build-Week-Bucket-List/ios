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
	let userController = UserController()
	var token: String? {
		return KeychainWrapper.standard.string(forKey: .accessTokenKey)
	}


	lazy var fetchedResultsController: NSFetchedResultsController<Item> = {
		return generateFetchedResultsController()
	}()


    override func viewDidLoad() {
        super.viewDidLoad()
        print(KeychainWrapper.standard.string(forKey: "access_token") ?? "token?")
        print("\(token ?? "")")
		print(userController.user?.username ?? "No username?")
        setColors()
        tableView.delegate = self
        tableView.dataSource = self
		tableView.tableFooterView = UIView()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		showModalIfNotLoggedIn()
		if token != nil {
			itemController.fetchAllItems()
		}
		tableView.refreshControl = UIRefreshControl()
		tableView.refreshControl?.addTarget(self, action: #selector(beginRefresh), for: .valueChanged)
		tableView.refreshControl?.tintColor = .white
//		 TODO: Figure out if token is being accessed correctly
	}

	@objc
	func beginRefresh() {
		itemController.fetchAllItems { (_) in
			DispatchQueue.main.async {
				self.tableView.refreshControl?.endRefreshing()
			}
		}
	}
    
	@IBAction func logoutTapped(_ sender: UIBarButtonItem) {
		KeychainWrapper.standard.removeObject(forKey: .accessTokenKey)
		CoreDataStack.shared.removeAllObjects()
//		CoreDataStack.shared.mainContext.reset()
//		resetFetchedResultsController()
		try? CoreDataStack.shared.save()
		print(token ?? "No Token")
		showModalIfNotLoggedIn()
	}

	func showModalIfNotLoggedIn() {
		if token == nil {
			performSegue(withIdentifier: "showLoginModalSegue", sender: self)
		}
		print("\(token ?? "")")
	}

	private func generateFetchedResultsController() -> NSFetchedResultsController<Item> {
		let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()

		let titleDescriptor = NSSortDescriptor(key: "itemtitle", ascending: true)
		let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
		fetchRequest.sortDescriptors = [completedDescriptor, titleDescriptor]

		let moc = CoreDataStack.shared.mainContext
		let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)

		frc.delegate = self
		do {
			try frc.performFetch()
		} catch {
			fatalError("Error performing fetch for frc: \(error)")
		}
		return frc
	}

	private func resetFetchedResultsController() {
		fetchedResultsController = generateFetchedResultsController()
	}

	private func setColors() {
        let icon = UIBarButtonItem(
            image: UIImage(named: "Icon.png")?.withRenderingMode(.alwaysOriginal),
            style: .plain, target: self, action: #selector(addNewItem))
        navigationItem.rightBarButtonItem = icon
        
        navigationController?.navigationBar.barTintColor = UIColor.eveningSea
        tabBarController?.tabBar.barTintColor = UIColor.eveningSea
        
        tabBarController?.tabBar.tintColor = UIColor.twilightBlue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.twilightBlue]
        
        self.navigationController?.navigationBar.tintColor = UIColor.twilightBlue;
        
        tableView.backgroundColor = .lochmara
        view.backgroundColor = .lochmara
    }
    
    @objc private func addNewItem() {
        performSegue(withIdentifier: "AddNewItemShowSegue", sender: self)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BLDetailViewShowSegue" {
			if let detailVC = segue.destination as? BucketListDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
				detailVC.itemController = itemController
				detailVC.item = fetchedResultsController.object(at: indexPath)
            }
        } else if segue.identifier == "AddNewItemShowSegue" {
            if let detailVC = segue.destination as? BucketListDetailViewController {
				detailVC.title = "Add New Adventure"
				detailVC.itemController = itemController
            }
        }
    }
}

extension BucketListTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BucketListCell", for: indexPath) as? BucketListTableViewCell else { return UITableViewCell() }

		let item = fetchedResultsController.object(at: indexPath)
        cell.item = item
        
        return cell
    }

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let item = fetchedResultsController.object(at: indexPath)
			itemController.deleteItem(item: item)
		}
	}
}

extension BucketListTableViewController: NSFetchedResultsControllerDelegate {
	func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		tableView.beginUpdates()
	}

	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		tableView.endUpdates()
	}

	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
		let sectionIndexSet = IndexSet(integer: sectionIndex)

		switch type {
		case .insert:
			tableView.insertSections(sectionIndexSet, with: .automatic)
		case .delete:
			tableView.deleteSections(sectionIndexSet, with: .automatic)
		default:
			break
		}
	}

	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
		switch type {
		case .delete:
			guard let indexPath = indexPath else { return }
			tableView.deleteRows(at: [indexPath], with: .fade)
		case .insert:
			guard let newIndexPath = newIndexPath else { return }
			tableView.insertRows(at: [newIndexPath], with: .fade)
		case .move:
			guard let indexPath = indexPath,
				let newIndexPath = newIndexPath else { return }
			tableView.moveRow(at: indexPath, to: newIndexPath)
		case .update:
			guard let indexPath = indexPath else { return }
			tableView.reloadRows(at: [indexPath], with: .fade)
		default:
			fatalError()
		}
	}
}

extension String {
	static let accessTokenKey = "access_token"
}
