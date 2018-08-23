//
//  VehiclesTableViewCell.swift
//  StarWars
//
//  Created by Juan Enriquez on 8/21/18.
//  Copyright © 2018 JuanEnriquez. All rights reserved.
//

import UIKit

protocol VehiclesCellDelegate {
    func vehicleDetailSelected(vehicleURL : String)
}
class VehiclesTableViewCell: UITableViewCell {

    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var vehicleURL : String?
    var delegate : VehiclesCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func detailsClick(_ sender: Any) {
        delegate?.vehicleDetailSelected(vehicleURL: vehicleURL!)
    }
    @IBAction func filmsClick(_ sender: Any) {
    }
}
