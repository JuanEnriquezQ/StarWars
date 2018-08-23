//
//  SingleFilmDetailController.swift
//  StarWars
//
//  Created by Juan Enriquez on 8/21/18.
//  Copyright © 2018 JuanEnriquez. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class SingleFilmDetailController: UIViewController {
    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l3: UILabel!
    @IBOutlet weak var producersLabel: UITextView!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var crawlLabel: UITextView!
    @IBOutlet weak var spinnerImage: UIImageView!
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var spinnerLoader: UIActivityIndicatorView!
    
    var film : Films?
    var url : String?
    var previousPage : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinnerImage.image = setupImageAnimation()
        getFilm(url: url!)
    }
    
    //PETICIÒN A LA API
    func getFilm(url : String){
        Alamofire.request(url,method: .get).responseJSON {
            response in
            if response.result.isSuccess{
                print("si se pudo")
                let resultJSON : JSON = JSON(response.result.value!)
                self.populateFilms(jsonResult: resultJSON)
            }
            else{
                print("HUBO UN ERROR")
            }
        }
    }//DE LA PETICION A LA API
    
    func populateFilms(jsonResult: JSON){
        let title = jsonResult["title"].string!
        let crawl = jsonResult["opening_crawl"].string!
        let director = jsonResult["director"].string!
        let producer = jsonResult["producer"].string!
        let date = jsonResult["release_date"].string!
        
        //LLENAR LABELS
        l1.isHidden = false
        l2.isHidden = false
        l3.isHidden = false
        
        self.filmTitle.text = title
        self.producersLabel.text = producer
        self.directorLabel.text = director
        self.releaseDate.text = date
        self.crawlLabel.text = crawl
        
        self.spinnerLoader.stopAnimating()
        self.spinnerImage.isHidden = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "returnFilms" {
            let vc2 = segue.destination as! ViewControllerList
            vc2.endingForeignKey = previousPage
        }
    }

}
