//
//  GnomeFetchedResultsController.swift
//  Altran
//
//  Created by Cesar Vilera on 1/9/17.
//  Copyright © 2017 Cesar Vilera. All rights reserved.
//

import UIKit
import CoreData

class GnomesFetchedResultsController: NSObject {
    public let listController: GnomeList
    let tableView: UITableView
    
    init(listController: GnomeList, tableView: UITableView) {
        self.listController = listController
        self.tableView = tableView
        super.init()
        listController.items.delegate = self
    }
}

extension GnomesFetchedResultsController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .none)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .none)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .none)
            }
            
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .none)
            }
        }
    }
}
