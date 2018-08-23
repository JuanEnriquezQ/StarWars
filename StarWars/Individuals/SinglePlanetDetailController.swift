//
//  SinglePlanetDetailController.swift
//  StarWars
//
//  Created by Juan Enriquez on 8/20/18.
//  Copyright © 2018 JuanEnriquez. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SinglePlanetDetailController: UIViewController {
    @IBOutlet weak var l8: UILabel!
    @IBOutlet weak var l7: UILabel!
    @IBOutlet weak var l6: UILabel!
    @IBOutlet weak var l5: UILabel!
    @IBOutlet weak var l4: UILabel!
    @IBOutlet weak var l3: UILabel!
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var planetNameLabel: UILabel!
    @IBOutlet weak var surfaceWaterLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var climateLabel: UILabel!
    @IBOutlet weak var rotationPeriodLabel: UILabel!
    @IBOutlet weak var orbitalPeriodLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var gravityLabel: UILabel!
    @IBOutlet weak var terrainLabel: UILabel!
    @IBOutlet weak var spinnerImage: UIImageView!
    @IBOutlet weak var spinnerLoader: UIActivityIndicatorView!
    
    var urlString : String?
    var previousPage : Int?
    var previousName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlanet(url: urlString!)
        spinnerImage.image = setupImageAnimation()
    }

    //PETICIÒN A LA API
    func getPlanet(url : String){
        Alamofire.request(url,method: .get).responseJSON {
            response in
            if response.result.isSuccess{
                print("si se pudo")
                let resultJSON : JSON = JSON(response.result.value!)
                print(resultJSON)
                //self.JSONToObject(jsonResult: resultJSON)
                self.populatePlanets(jsonResult: resultJSON)
            }
            else{
                print("HUBO UN ERROR")
            }
        }
    }//DE LA PETICION A LA API
    
    func populatePlanets(jsonResult: JSON){
        let name = jsonResult["name"].string!
        let climate = jsonResult["climate"].string!
        let gravity = jsonResult["gravity"].string!
        let rotationPeriod = jsonResult["rotation_period"].string!
        let population = jsonResult["population"].string!
        let terrain = jsonResult["terrain"].string!
        let orbital = jsonResult["orbital_period"].string!
        let surface = jsonResult["surface_water"].string!
        let diameter = jsonResult["diameter"].string!
        
        //LLENAR LABELS
        planetNameLabel.text = name
        climateLabel.text = climate
        gravityLabel.text = gravity
        rotationPeriodLabel.text = rotationPeriod
        populationLabel.text = population
        terrainLabel.text = terrain
        orbitalPeriodLabel.text = orbital
        diameterLabel.text = diameter
        surfaceWaterLabel.text = surface
        
        self.spinnerLoader.stopAnimating()
        spinnerImage.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "returnPlanets" {
            let vc2 = segue.destination as! ViewControllerList
            vc2.endingForeignKey = previousPage
            vc2.nameForeign = previousName
        }
    }
}
