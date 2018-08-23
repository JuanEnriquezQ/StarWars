//
//  PersonTableViewCell.swift
//  StarWars
//
//  Created by Juan Enriquez on 8/20/18.
//  Copyright © 2018 JuanEnriquez. All rights reserved.
//

import UIKit

protocol PersonDelegate {
    func planetSelected(planetURL : String)
    func speciesSelected(speciesURL : String)
    //func filmsSelected(filmsURL : String)
}

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var imageHolder: UIImageView!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var personNameLabel: UILabel!
    
    //foreign attributes
    var movies : [String]?
    var planetUrl = ""
    var speciesURL = ""
    
    var delegate : PersonDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func planetAction(_ sender: Any) {
        delegate?.planetSelected(planetURL: planetUrl)
    }
    @IBAction func moviesAction(_ sender: Any) {
    }
    @IBAction func speciesAction(_ sender: Any) {
        delegate?.speciesSelected(speciesURL: speciesURL)
    }
    @IBOutlet weak var planetsButton: UIButton!
    
}
