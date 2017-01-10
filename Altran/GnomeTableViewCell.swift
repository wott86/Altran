//
//  GnomeTableViewCell.swift
//  Altran
//
//  Created by Cesar Vilera on 1/8/17.
//  Copyright © 2017 Cesar Vilera. All rights reserved.
//

import UIKit

class GnomeTableViewCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var professions: UILabel!
    
    static let identifier = "GnomeCellIdentifier"
    var gnome: Gnome?
    
    func configure(with gnome: Gnome) {
        self.gnome = gnome
        name.text = gnome.name
        DispatchQueue.main.async {
            self.avatar.image = gnome.avatar
        }
        professions.text = gnome.professions
    }
}
