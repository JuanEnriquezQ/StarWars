//
//  PlanetTableViewCell.swift
//  StarWars
//
//  Created by Juan Enriquez on 8/21/18.
//  Copyright © 2018 JuanEnriquez. All rights reserved.
//

import UIKit


class PlanetTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var climateLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var imageOutlet: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func moreDetailsButton(_ sender: Any) {
    }
    @IBAction func showResidents(_ sender: Any) {
    }
    @IBAction func showFilms(_ sender: Any) {
    }
    
}
