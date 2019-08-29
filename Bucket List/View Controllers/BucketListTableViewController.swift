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
    let token: String? = KeychainWrapper.standard.string(forKey: "access_token")

//	var user: UserRepresentation {
//		let moc = CoreDataStack.shared.mainContext
//		let request: NSFetchRequest<User> = User.fetchRequest()
//
//		do {
//			let users = try moc.fetch(request)
//			if let user = users.first {
//				return user.userRepresentation
//			}
//		} catch {
//			fatalError("Error performing fetch for users: \(error)")
//		}
//		return UserRepresentation()
//	}

//	var user: User {
//		let moc = CoreDataStack.shared.mainContext
//		let request = NSFetchRequest<UserRepresentation> = UserRepresentation.fetchRequest()
//	}

	lazy var fetchedResultsController: NSFetchedResultsController<Item> = {
		let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()

		let titleDescriptor = NSSortDescriptor(key: "title", ascending: true)
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
	}()


    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(token ?? "")")
		print(userController.user?.username ?? "No username?")
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
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BucketListCell", for: indexPath) as? BucketListTableViewCell else { return UITableViewCell() }

		let item = fetchedResultsController.object(at: indexPath)
        cell.item = item
        
        return cell
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

