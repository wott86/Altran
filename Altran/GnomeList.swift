//
//  GnomeList.swift
//  Altran
//
//  Created by Cesar Vilera on 1/8/17.
//  Copyright © 2017 Cesar Vilera. All rights reserved.
//

import Foundation
import CoreData

class GnomeList {
    
    var items: NSFetchedResultsController<Gnomes>
    var selectedItem: Gnome?
    
    init() {
        items = Gnomes.list(context: AppDelegate.getContext())
        if items.fetchedObjects?.count == 0 {
            GnomeList.getGnomeList()
        }
    }
    
    class func getGnomeList() {
        let networkManager = NetworkManager()
        networkManager.get(stringURL: "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json") { (response, error) in
            let context = AppDelegate.getContext()
            guard error == nil else {
                return
            }
            context.perform {
                guard let responseData = response as? [String: AnyObject] else {
                    return
                }
                if let items = responseData["Brastlewark"] {
                    for item in (items as! Array<[String: AnyObject]>) {
                        _ = Gnomes.insertOrUpdate(with: item, context: context)
                    }
                }
            }
        }
    }
    
}
