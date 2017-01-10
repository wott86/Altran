//
//  GnomeDetailsViewController.swift
//  Altran
//
//  Created by Cesar Vilera on 1/8/17.
//  Copyright © 2017 Cesar Vilera. All rights reserved.
//

import UIKit

class GnomeDetailsViewController: UIViewController {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var professionsLabel: UILabel!
    @IBOutlet weak var friendsLabel: UILabel!
    
    var gnome: Gnome?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        avatar.image = gnome?.avatar
        nameLabel.text = gnome?.name
        ageLabel.text = gnome?.age
        hairColorLabel.text = gnome?.hairColor
        heightLabel.text = gnome?.height
        weightLabel.text = gnome?.weight
        professionsLabel.text = gnome?.professions
        friendsLabel.text = gnome?.friends
    }
}
