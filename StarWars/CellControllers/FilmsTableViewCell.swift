//
//  FilmsTableViewCell.swift
//  StarWars
//
//  Created by Juan Enriquez on 8/21/18.
//  Copyright © 2018 JuanEnriquez. All rights reserved.
//

import UIKit

protocol FilmCellDelegate {
    func filmsDetailSelected(filmURL : String)
}
class FilmsTableViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    
    var filmURL : String?
    var delegate : FilmCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func starshipsClick(_ sender: Any) {
    }
    @IBAction func vehiclesClick(_ sender: Any) {
    }
    @IBAction func speciesClick(_ sender: Any) {
    }
    @IBAction func planetsClick(_ sender: Any) {
    }
    @IBAction func charactersClick(_ sender: Any) {
    }
    @IBAction func detailsClick(_ sender: Any) {
        delegate?.filmsDetailSelected(filmURL: filmURL!)
    }
    
    
}
