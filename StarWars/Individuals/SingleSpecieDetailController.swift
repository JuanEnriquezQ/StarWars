//
//  SingleSpecieDetailController.swift
//  StarWars
//
//  Created by Juan Enriquez on 8/21/18.
//  Copyright © 2018 JuanEnriquez. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SingleSpecieDetailController: UIViewController {
    @IBOutlet weak var classificationLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var lifespanLabel: UILabel!
    @IBOutlet weak var hairLabel: UILabel!
    @IBOutlet weak var skinLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var designationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var spinnerLoader: UIActivityIndicatorView!
    var url : String?
    var previousPage : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSpecie(url: url!)
    }
    
    //PETICIÒN A LA API
    func getSpecie(url : String){
        Alamofire.request(url,method: .get).responseJSON {
            response in
            if response.result.isSuccess{
                print("si se pudo")
                let resultJSON : JSON = JSON(response.result.value!)
                print(resultJSON)
                self.populateSpecie(jsonResult: resultJSON)
            }
            else{
                print("HUBO UN ERROR")
            }
        }
    }//DE LA PETICION A LA API
    
    func populateSpecie(jsonResult: JSON){
        let name = jsonResult["name"].string!
        let classification = jsonResult["classification"].string!
        let dessignation = jsonResult["designation"].string!
        let height = jsonResult["average_height"].string!
        let hairColor = jsonResult["hair_colors"].string!
        let skinColor = jsonResult["skin_colors"].string!
        let lifespan = jsonResult["average_lifespan"].string!
        let language = jsonResult["language"].string!
        
        //LLENAR LABELS
        self.nameLabel.text = name
        self.classificationLabel.text = classification
        self.designationLabel.text = dessignation
        self.heightLabel.text = height
        self.hairLabel.text = hairColor
        self.skinLabel.text = skinColor
        self.lifespanLabel.text = lifespan
        self.languageLabel.text = language
        
        self.spinnerLoader.stopAnimating()
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "returnSpecies" {
            let vc2 = segue.destination as! ViewControllerList
            vc2.endingForeignKey = previousPage
        }
    }

}
