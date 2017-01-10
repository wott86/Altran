//
//  Gnome.swift
//  Altran
//
//  Created by Cesar Vilera on 1/9/17.
//  Copyright © 2017 Cesar Vilera. All rights reserved.
//

import UIKit
import CoreData

class Gnome {
    private var gnome: Gnomes
    let name: String?
    let professions: String?
    var avatar: UIImage?
    let age: String?
    let height: String?
    let weight: String?
    let friends: String?
    let hairColor: String?
    
    init(gnome: Gnomes) {
        self.gnome = gnome
        self.name = gnome.name
        self.professions = gnome.professions
        self.age = "\(gnome.age)"
        self.height = "\(gnome.height)"
        self.weight = "\(gnome.weight)"
        self.friends = gnome.friends
        self.hairColor = gnome.hair_color
        if let thumbnailData = gnome.thumbnail_data as Data? {
            self.avatar = UIImage(data: thumbnailData)
        }else {
            self.avatar = #imageLiteral(resourceName: "no-img")
            getImage()
        }
    }
    
    func getImage() {
        guard let thumbnail = gnome.thumbnail else {
            return
        }
        
        let networkManager = NetworkManager()
        
        networkManager.getImage(stringURL: thumbnail) { (data, error) in
            guard error == nil else {
                return
            }
            guard let data = data as! Data?, let image = UIImage(data: data) else {
                return
            }
            self.avatar = image
            self.gnome.managedObjectContext?.perform {
                self.gnome.setImage(with: data)
                AppDelegate.saveContext(context: self.gnome.managedObjectContext!)
            }
        }
    }
}
