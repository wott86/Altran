//
//  Gnome.swift
//  Altran
//
//  Created by Cesar Vilera on 1/8/17.
//  Copyright © 2017 Cesar Vilera. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension NSManagedObject {
    
    public class func entityName() -> String {
        let name = NSStringFromClass(self)
        return name.components(separatedBy: ".").last!
    }
    
}

extension Gnomes {
    
    struct propertyNames {
        static let id = "id"
        static let name = "name"
        static let age = "age"
        static let hairColor = "hair_color"
        static let height = "height"
        static let weight = "weight"
        static let thumbnail = "thumbnail"
        static let friends = "friends"
        static let professions = "professions"
        static let thumbnailData = "thumbnail_data"
    }
    
    class func get(id: Int64, context: NSManagedObjectContext) -> Gnomes? {
        let predicate = NSPredicate(format: "\(propertyNames.id) == \(id)")
        return self.list(predicate: predicate, context: context).fetchedObjects?.first
    }
    
    class func list(predicate: NSPredicate? = nil, fetchLimit: Int = 0, context: NSManagedObjectContext) -> NSFetchedResultsController<Gnomes> {
        
        let fetchRequest = NSFetchRequest<Gnomes>(entityName: self.entityName())
        fetchRequest.fetchLimit = 0
        fetchRequest.fetchBatchSize = 20
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: propertyNames.id, ascending: true)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        do {
           try fetchedResultsController.performFetch()
        }catch {
            
        }
        return fetchedResultsController
    }
    
    class func insertOrUpdate(id: Int64 ,name: String?, age: Int64?, hairColor: String?, height: Double?, weight: Double?, thumbnail: String?, friends: String?, professions: String?, context: NSManagedObjectContext) -> Gnomes {
        var gnome: Gnomes
        
        if let result = Gnomes.get(id: id, context: context) {
            gnome = result
        }else {
            gnome = NSEntityDescription.insertNewObject(forEntityName: self.entityName(), into: context) as! Gnomes
        }
        
        gnome.id = id
        gnome.name = name
        gnome.age = age ?? 0
        gnome.hair_color = hairColor
        gnome.height = height ?? 0
        gnome.weight = weight ?? 0
        gnome.thumbnail = thumbnail
        gnome.friends = friends
        gnome.professions = professions
        
        return gnome
    }
    
    class func insertOrUpdate(with dictionary: Dictionary<String, Any>, context: NSManagedObjectContext) -> Gnomes {
        let id = dictionary[propertyNames.id] as! Int64
        let name = dictionary[propertyNames.name] as! String
        let age = dictionary[propertyNames.age] as! Int64
        let hairColor = dictionary[propertyNames.hairColor] as! String
        let height = dictionary[propertyNames.height] as! Double
        let weight = dictionary[propertyNames.weight] as! Double
        let thumbnail = dictionary[propertyNames.thumbnail] as! String
        let friendsArray = dictionary[propertyNames.friends] as! Array<String>
        let friends = friendsArray.toString()
        let professionsArray = dictionary[propertyNames.professions] as! Array<String>
        let professions = professionsArray.toString()
        
        return self.insertOrUpdate(id: id, name: name, age: age, hairColor: hairColor, height: height, weight: weight, thumbnail: thumbnail, friends: friends, professions: professions, context: context)
    }
    
    func setImage(with data: Data) {
        self.thumbnail_data = data as NSData
    }
    
}

