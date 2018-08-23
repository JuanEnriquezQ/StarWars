//
//  SpeciesTableViewCell.swift
//  StarWars
//
//  Created by Juan Enriquez on 8/21/18.
//  Copyright © 2018 JuanEnriquez. All rights reserved.
//

import UIKit

protocol SpeciesCellDelegate {
    func speciesDetailSelected(speciesURL : String)
   
}
class SpeciesTableViewCell: UITableViewCell {

    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var specieURL : String?
    var delegate : SpeciesCellDelegate?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func detailsClick(_ sender: Any) {
        delegate?.speciesDetailSelected(speciesURL: specieURL!)
    }
    @IBAction func charactersClick(_ sender: Any) {
    }
    @IBAction func homeworldClick(_ sender: Any) {
    }
    
}
