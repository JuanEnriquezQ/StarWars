//
//  ViewController.swift
//  StarWars
//
//  Created by Juan Enriquez on 8/16/18.
//  Copyright © 2018 JuanEnriquez. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {
    
    var titleExport : String?
    var senderKey : Int?
    var PeopleList = [People]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func viewAllScreen(_ sender: UIButton) {
        let senderTagID = sender.tag
        let senderTitle : String
        let errorTitle = "Unknown Error At Switch"
        
        switch senderTagID {
        case 0:
            senderTitle = "People"
            senderKey = 0
        case 1:
            senderTitle = "Films"
            senderKey = 1
        case 2:
            senderTitle = "Species"
            senderKey = 2
        case 3:
            senderTitle = "Vehicles"
            senderKey = 3
        case 4:
            senderTitle = "Planets"
            senderKey = 4
        case 5:
            senderTitle = "Starships"
            senderKey = 5
        default:
            senderTitle = errorTitle
        }
        
        if senderTitle != errorTitle  {
            titleExport = senderTitle
            performSegue(withIdentifier: "showAllSegue", sender: self)
        } else {
            print("error: \(errorTitle)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAllSegue"{
            let vc2 = segue.destination as! ViewControllerList
            vc2.nameForeign = self.titleExport
            vc2.endingForeignKey = self.senderKey!
        }
    }
    

    
    
    

}

