//
//  Starships.swift
//  StarWars
//
//  Created by Juan Enriquez on 8/16/18.
//  Copyright © 2018 JuanEnriquez. All rights reserved.
//

import Foundation

struct Starships{
    var name : String
    var model : String
    var manufacturer : String
    var costInCredits : String
    var length : String
    var maxAtmospheringSpeed : String
    var crew : String
    var passengers : String
    var cargoCapacity : String
    var consumables : String
    var hyperDriveRating : String
    var mglt : String
    var starshipClass : String
    
    var pilots : [People]?
    var films : [Films]?
    var url : String
}
