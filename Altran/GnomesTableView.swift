//
//  GnomesTableView.swift
//  Altran
//
//  Created by Cesar Vilera on 1/8/17.
//  Copyright © 2017 Cesar Vilera. All rights reserved.
//

import UIKit

class GnomesTableView: NSObject {
    public let listController: GnomeList
    
    init(listController: GnomeList, tableView: UITableView) {
        self.listController = listController
        super.init()
        tableView.dataSource = self
    }
}

extension GnomesTableView: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections = listController.items.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = listController.items.sections {
            let currentSection = sections[section]
            return currentSection.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gnome = Gnome(gnome: listController.items.object(at: indexPath))
        let cell = tableView.dequeueReusableCell(withIdentifier: GnomeTableViewCell.identifier, for: indexPath) as! GnomeTableViewCell
        cell.configure(with: gnome)
        return cell
    }
    
}
