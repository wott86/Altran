//
//  GnomeListTableViewController.swift
//  Altran
//
//  Created by Cesar Vilera on 1/8/17.
//  Copyright © 2017 Cesar Vilera. All rights reserved.
//

import UIKit

class GnomeListTableViewController: UITableViewController {
    var gnomeList = GnomeList()
    var gnomesTableView: GnomesTableView?
    var gnomesFetchedResultsController: GnomesFetchedResultsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gnomesTableView = GnomesTableView(listController: gnomeList, tableView: tableView)
        gnomesFetchedResultsController = GnomesFetchedResultsController(listController: gnomeList, tableView: tableView)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = Gnome(gnome: gnomeList.items.object(at: indexPath))
        gnomeList.selectedItem = selectedItem
        self.performSegue(withIdentifier: "MoveToGnomeDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is GnomeDetailsViewController {
            let destination = segue.destination as! GnomeDetailsViewController
            destination.gnome = gnomeList.selectedItem
        }
    }
    
}
