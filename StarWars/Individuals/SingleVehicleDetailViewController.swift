//
//  SingleVehicleDetailViewController.swift
//  StarWars
//
//  Created by Juan Enriquez on 8/21/18.
//  Copyright © 2018 JuanEnriquez. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SingleVehicleDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var consumablesLabel: UILabel!
    @IBOutlet weak var cargoLabel: UILabel!
    @IBOutlet weak var passengersLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var costaLabel: UILabel!
    @IBOutlet weak var spinnerLoader: UIActivityIndicatorView!
    
    var vehicle : Vehicles?
    var url : String?
    var previousPage : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVehicle(url: url!)
    }

    
    //PETICIÒN A LA API
    func getVehicle(url : String){
        Alamofire.request(url,method: .get).responseJSON {
            response in
            if response.result.isSuccess{
                print("si se pudo")
                let resultJSON : JSON = JSON(response.result.value!)
                print(resultJSON)
                self.populateVehicle(jsonResult: resultJSON)
            }
            else{
                print("HUBO UN ERROR")
            }
        }
    }//DE LA PETICION A LA API
    
    func populateVehicle(jsonResult: JSON){
        let name = jsonResult["name"].string!
        let model = jsonResult["model"].string!
        let manufacturer = jsonResult["manufacturer"].string!
        let cost = jsonResult["cost_in_credits"].string!
        let length = jsonResult["length"].string!
        let speed = jsonResult["max_atmosphering_speed"].string!
        let crew = jsonResult["crew"].string!
        let passengers = jsonResult["passengers"].string!
        let capacity = jsonResult["cargo_capacity"].string!
        let consumables = jsonResult["consumables"].string!
        let vclass = jsonResult["vehicle_class"].string!
        
        //LLENAR LABELS
        self.nameLabel.text = name
        self.modelLabel.text = model
        self.manufacturerLabel.text = manufacturer
        self.costaLabel.text = cost
        self.lengthLabel.text = length
        self.speedLabel.text = speed
        self.crewLabel.text = crew
        self.passengersLabel.text = passengers
        self.cargoLabel.text = capacity
        self.consumablesLabel.text = consumables
        self.classLabel.text = vclass
        
        self.spinnerLoader.stopAnimating()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "returnVehicles" {
            let vc2 = segue.destination as! ViewControllerList
            vc2.endingForeignKey = previousPage
        }
    }
}
