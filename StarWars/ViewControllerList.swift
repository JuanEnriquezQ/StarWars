//
//  ViewControllerList.swift
//  StarWars
//
//  Created by Juan Enriquez on 8/16/18.
//  Copyright © 2018 JuanEnriquez. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import FirebaseStorage


class ViewControllerList: UIViewController, UITableViewDelegate, UITableViewDataSource, PersonDelegate, FilmCellDelegate, SpeciesCellDelegate, VehiclesCellDelegate{
    func vehicleDetailSelected(vehicleURL: String) {
        nextScreenURL = vehicleURL
        self.performSegue(withIdentifier: "vehicleDetail", sender: self)
    }
    
    func speciesDetailSelected(speciesURL: String) {
        nextScreenURL = speciesURL
        self.performSegue(withIdentifier: "speciesDetail", sender: self)
        
    }
    
    func filmsDetailSelected(filmURL: String) {
        nextScreenURL = filmURL
        self.performSegue(withIdentifier: "filmDetail", sender: self)
    }
    
    func speciesSelected(speciesURL: String) {
        nextScreenURL = speciesURL
        self.performSegue(withIdentifier: "speciesDetail", sender: self)
    }
    
    func planetSelected(planetURL: String) {
        nextScreenURL = planetURL
        self.performSegue(withIdentifier: "planetDetail", sender: self)
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch endingForeignKey {
        case 0:
            return PeopleList.count
        case 1:
            return FilmList.count
        case 2:
            return SpeciesList.count
        case 3:
            return VehicleList.count
        case 4:
            print("es 4")
            return PlanetList.count
        default:
            print("no llegó nada")
        }
        return PeopleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch endingForeignKey {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath) as! PersonTableViewCell
            cell.personNameLabel.text = PeopleList[indexPath.row].name
            cell.yearLabel.text = PeopleList[indexPath.row].birthYear
            cell.genderLabel.text = PeopleList[indexPath.row].gender
            cell.eyeColorLabel.text = PeopleList[indexPath.row].eyeColor
            cell.hairColorLabel.text = PeopleList[indexPath.row].hairColor
            cell.heightLabel.text = PeopleList[indexPath.row].height
            cell.massLabel.text = PeopleList[indexPath.row].mass
            cell.imageHolder.image = UIImage(named: PeopleList[indexPath.row].name)
            cell.planetUrl = PeopleList[indexPath.row].homeWorldURL
            cell.movies = PeopleList[indexPath.row].films
            cell.speciesURL = PeopleList[indexPath.row].species
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath) as! FilmsTableViewCell
            cell.name.text = FilmList[indexPath.row].title
            cell.id.text = String(FilmList[indexPath.row].episodeId)
            cell.director.text = FilmList[indexPath.row].director
            cell.date.text = FilmList[indexPath.row].releaseDate
            cell.filmURL = FilmList[indexPath.row].url
            cell.delegate = self
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "speciesCell", for: indexPath) as! SpeciesTableViewCell
            cell.nameLabel.text = SpeciesList[indexPath.row].name
            cell.classLabel.text = SpeciesList[indexPath.row].classification
            cell.languageLabel.text = SpeciesList[indexPath.row].language
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "vehicleCell", for: indexPath) as! VehiclesTableViewCell
            
            cell.nameLabel.text = VehicleList[indexPath.row].name
            cell.manufacturerLabel.text = VehicleList[indexPath.row].manufacturer
            cell.modelLabel.text = VehicleList[indexPath.row].model
            cell.vehicleURL = VehicleList[indexPath.row].url
            cell.delegate = self
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "planetCell", for: indexPath) as! PlanetTableViewCell
            cell.nameLabel.text = PlanetList[indexPath.row].name
            cell.diameterLabel.text = PlanetList[indexPath.row].diameter
            cell.populationLabel.text = PlanetList[indexPath.row].population
            cell.climateLabel.text = PlanetList[indexPath.row].climate
            return cell
            
        default:
            print("que es lo que pasò?")
            let cell = tableView.dequeueReusableCell(withIdentifier: "planetCell", for: indexPath) as! PlanetTableViewCell
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch endingForeignKey {
        case 0:
            return 210
        case 1:
            return 175.67
        case 2:
            return 116
        case 3:
            return 115.67
        case 4:
            return 176
        default:
            return 100
        }
    }
    
    @IBOutlet weak var imageSpinner: UIImageView!
    @IBOutlet weak var loaderSpinner: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    var testNameSubject : String = ""
    var numberOfItemsReturned : Int = 0
    
    var nameForeign : String?
    var endingForeignKey : Int?
    

    var PeopleList = [People]()
    var FilmList = [Films]()
    var VehicleList = [Vehicles]()
    var StarshipList = [Starships]()
    var PlanetList = [Planets]()
    var SpeciesList = [Species]()
    
    var nextScreenURL = ""
    
    var personImageDict = ["Luke Skywalker":"luke.png","C-3PO":"c3po.png","R2-D2":"r2d2.png","Darth Vader":"darth.png","Leia Organa":"leia.png","Owen Lars":"owen.png","Beru Whitesun lars":"beru.png","R5-D4":"r5d4.png","Biggs Darklighter":"bigss.png","Obi-Wan Kenobi":"obiwan.png"]

    var url : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = nameForeign
        imageSpinner.image = setupImageAnimation()
        url = chooseURLEnding(ending: endingForeignKey!)
        getSelectedItem(url: url!)
       
    }
    
    
    //PETICIÒN A LA API
    func getSelectedItem(url : String){
        Alamofire.request(url,method: .get).responseJSON {
            response in
            if response.result.isSuccess{
                print("si se pudo")
                let resultJSON : JSON = JSON(response.result.value!)
                print(resultJSON)
                //JSONToObject(resultJSON)
                self.JSONToObject(jsonResult: resultJSON, typeOfClass: self.endingForeignKey!)
            }
            else{
                print("HUBO UN ERROR")
            }
        }
    }
    
    //DETECTA QUE TIPO DE REQUEST ES EN BASE AL BOTÓN PRESIONADO EN EL VIEW ANTERIOR
    func chooseURLEnding(ending : Int) -> String {
        let url : String
        switch ending {
        case 0:
            url = "https://swapi.co/api/people/"
        case 1:
            url = "https://swapi.co/api/films/"
        case 2:
            url = "https://swapi.co/api/species/"
        case 3:
            url = "https://swapi.co/api/vehicles/"
        case 4:
            url = "https://swapi.co/api/planets/"
        case 5:
            url = "https://swapi.co/api/starships/"
        default:
            url = "ERROR AL CARGAR URLS"
        }
        return url
    }
    func JSONToObject(jsonResult : JSON, typeOfClass : Int){
        let noItemsNow = jsonResult["results"].array?.count
        populateArrays(maxIndex: noItemsNow!, typeOfClass: typeOfClass, jsonResult: jsonResult)
        return
    }
    
    //RECORRE TODO EL JSON Y CREA OBJETOS PARA METERLOS EN UN ARREGLO
    func populateArrays(maxIndex : Int, typeOfClass : Int, jsonResult: JSON) {
        var counter = 0
        var filmsCounter = 0
        switch typeOfClass {
        case 0: //People Filler
            while counter < maxIndex{
                let resultFilmCounter = jsonResult["results"][counter]["films"].array?.count
                
                let jsonName = jsonResult["results"][counter]["name"].string!
                let jsonHeight = jsonResult["results"][counter]["height"].string!
                let jsonMass = jsonResult["results"][counter]["mass"].string!
                let jsonHairColor = jsonResult["results"][counter]["hair_color"].string!
                let jsonSkinColor = jsonResult["results"][counter]["skin_color"].string!
                let jsonEyeColor = jsonResult["results"][counter]["eye_color"].string!
                let jsonBirthYear = jsonResult["results"][counter]["birth_year"].string!
                let jsonGender = jsonResult["results"][counter]["gender"].string!
                let jsonHomeworldURL = jsonResult["results"][counter]["homeworld"].string!
                let jsonURL = jsonResult["results"][counter]["url"].string!
                let jsonSpecies = jsonResult["results"][counter]["species"][0].string!
                var jsonFilmsList = [String]()
                
                while filmsCounter < resultFilmCounter!{
                    jsonFilmsList.append(jsonResult["results"][counter]["films"][filmsCounter].string!)
                    filmsCounter += 1
                }
                filmsCounter = 0
                let newPerson = People(name: jsonName, height: jsonHeight, mass: jsonMass, hairColor: jsonHairColor, skinColor: jsonSkinColor, eyeColor: jsonEyeColor, birthYear: jsonBirthYear, gender: jsonGender, homeWorldURL: jsonHomeworldURL, films: jsonFilmsList, url: jsonURL, species: jsonSpecies)
                self.PeopleList.append(newPerson)
                
                counter += 1
            }
            tableView.reloadData()
            loaderSpinner.stopAnimating()
            imageSpinner.isHidden = true
            tableView.isHidden = false
        //para los films
        case 1:
            while counter < maxIndex{
                var vehiclesCounter = 0
                var charactersCounter = 0
                var starshipsCounter = 0
                var planetsCounter = 0
                var speciesCounter = 0
                
                let totalVehicles = jsonResult["results"][counter]["vehicles"].array?.count
                let totalCharacters = jsonResult["results"][counter]["characters"].array?.count
                let totalPlanets = jsonResult["results"][counter]["planets"].array?.count
                let totalSpecies = jsonResult["results"][counter]["species"].array?.count
                let totalStarships = jsonResult["results"][counter]["starships"].array?.count
                
                var vehicleList = [String]()
                var characterList = [String]()
                var starshipsList = [String]()
                var planetsList = [String]()
                var speciesList = [String]()
                
                let title = jsonResult["results"][counter]["title"].string!
                let id = jsonResult["results"][counter]["episode_id"].int!
                let crawl = jsonResult["results"][counter]["opening_crawl"].string!
                let director = jsonResult["results"][counter]["director"].string!
                let producer = jsonResult["results"][counter]["producer"].string!
                let releaseDate = jsonResult["results"][counter]["release_date"].string!
                let url = jsonResult["results"][counter]["url"].string!
                
                while vehiclesCounter < totalVehicles!{
                    vehicleList.append(jsonResult["results"][counter]["vehicles"][vehiclesCounter].string!)
                    vehiclesCounter += 1
                }
                while charactersCounter < totalCharacters!{
                    characterList.append(jsonResult["results"][counter]["characters"][charactersCounter].string!)
                    charactersCounter += 1
                }
                while starshipsCounter < totalStarships!{
                    starshipsList.append(jsonResult["results"][counter]["starships"][starshipsCounter].string!)
                    starshipsCounter += 1
                }
                while planetsCounter < totalPlanets!{
                    planetsList.append(jsonResult["results"][counter]["planets"][planetsCounter].string!)
                    planetsCounter += 1
                }
                while speciesCounter < totalSpecies!{
                    speciesList.append(jsonResult["results"][counter]["species"][speciesCounter].string!)
                    speciesCounter += 1
                }
                
                let newFilm = Films(title: title, episodeId: id, openingCrawl: crawl, director: director, producer: producer, releaseDate: releaseDate, characters: characterList, planets: planetsList, starships: starshipsList, vehicles: vehicleList, species: speciesList, url: url)
                FilmList.append(newFilm)
                counter += 1
            }
            tableView.reloadData()
            loaderSpinner.stopAnimating()
            imageSpinner.isHidden = true
            tableView.isHidden = false
            
        //para lista de Species
        case 2:
            while counter < maxIndex{
                var filmsCounter = 0
                var peopleCounter = 0
                let totalFilms = jsonResult["results"][counter]["films"].array?.count
                let totalPeople = jsonResult["results"][counter]["people"].array?.count
                var filmList = [String]()
                var peopleList = [String]()
                
                let name = jsonResult["results"][counter]["name"].string!
                let classification = jsonResult["results"][counter]["classification"].string!
                let designation = jsonResult["results"][counter]["designation"].string!
                let averageHeight = jsonResult["results"][counter]["average_height"].string!
                let skinColors = jsonResult["results"][counter]["skin_colors"].string!
                let hairColors = jsonResult["results"][counter]["hair_colors"].string!
                let eyeColors = jsonResult["results"][counter]["eye_colors"].string!
                let averageLifeSpan = jsonResult["results"][counter]["average_lifespan"].string!
                let homeWorld = jsonResult["results"][counter]["homeworld"].string!
                let language = jsonResult["results"][counter]["language"].string!
                let url = jsonResult["results"][counter]["url"].string!
                
                while filmsCounter < totalFilms!{
                    filmList.append(jsonResult["results"][counter]["films"][filmsCounter].string!)
                    filmsCounter += 1
                }
                while peopleCounter < totalPeople!{
                    peopleList.append(jsonResult["results"][counter]["people"][peopleCounter].string!)
                    peopleCounter += 1
                }
                
                let newSpecie = Species(name: name, classification: classification, designation: designation, averageHeight: averageHeight, skinColors: skinColors, hairColors: hairColors, eyeColors: eyeColors, averageLifeSpan: averageLifeSpan, homeWorld: homeWorld, language: language, people: peopleList, films: filmList, url: url)
                
                SpeciesList.append(newSpecie)
                counter += 1
            }
            tableView.reloadData()
            loaderSpinner.stopAnimating()
            imageSpinner.isHidden = true
            tableView.isHidden = false
        
            //lista de vehiculos
        case 3:
            while counter < maxIndex{
                var pilotsCounter = 0
                var filmsCounter = 0
                
                let totalPilots = jsonResult["results"][counter]["pilots"].array?.count
                let totalFilms = jsonResult["results"][counter]["films"].array?.count
                
                var filmList = [String]()
                var pilotsList = [String]()
                
                
                let name = jsonResult["results"][counter]["name"].string!
                let model = jsonResult["results"][counter]["model"].string!
                let manufacturer = jsonResult["results"][counter]["manufacturer"].string!
                let cost = jsonResult["results"][counter]["cost_in_credits"].string!
                let lenght = jsonResult["results"][counter]["cost_in_credits"].string!
                let speed = jsonResult["results"][counter]["cost_in_credits"].string!
                let crew = jsonResult["results"][counter]["cost_in_credits"].string!
                let passengers = jsonResult["results"][counter]["cost_in_credits"].string!
                let cargo = jsonResult["results"][counter]["cost_in_credits"].string!
                let consumables = jsonResult["results"][counter]["cost_in_credits"].string!
                let classs = jsonResult["results"][counter]["cost_in_credits"].string!
                let url = jsonResult["results"][counter]["url"].string!
                
                while pilotsCounter < totalPilots!{
                    pilotsList.append(jsonResult["results"][counter]["pilots"][pilotsCounter].string!)
                    pilotsCounter += 1
                }
                while filmsCounter < totalFilms!{
                    filmList.append(jsonResult["results"][counter]["films"][filmsCounter].string!)
                    filmsCounter += 1
                }
                
                
                let newVehicle = Vehicles(name: name, model: model, manufacturer: manufacturer, costInCredits: cost, length: lenght, maxAtmospheringSpeed: speed, crew: crew, passengers: passengers, cargoCapacity: cargo, consumables: consumables, vehicleClass: classs, pilots: pilotsList , films: filmList, url: url)
                VehicleList.append(newVehicle)
                counter += 1
            }
            tableView.reloadData()
            loaderSpinner.stopAnimating()
            imageSpinner.isHidden = true
            tableView.isHidden = false
        //para lista de planetas
        case 4:
            while counter < maxIndex{
                var filmsCounter = 0
                var residentsCounter = 0
                
                let totalFilms = jsonResult["results"][counter]["films"].array?.count
                let totalResidents = jsonResult["results"][counter]["residents"].array?.count
                var filmList = [String]()
                var residentList = [String]()
                
                let name = jsonResult["results"][counter]["name"].string!
                let climate = jsonResult["results"][counter]["climate"].string!
                let gravity = jsonResult["results"][counter]["gravity"].string!
                let rotationPeriod = jsonResult["results"][counter]["rotation_period"].string!
                let population = jsonResult["results"][counter]["population"].string!
                let terrain = jsonResult["results"][counter]["terrain"].string!
                let orbital = jsonResult["results"][counter]["orbital_period"].string!
                let surface = jsonResult["results"][counter]["surface_water"].string!
                let diameter = jsonResult["results"][counter]["diameter"].string!
                let url = jsonResult["results"][counter]["url"].string!
                
                while filmsCounter < totalFilms!{
                    filmList.append(jsonResult["results"][counter]["films"][filmsCounter].string!)
                    filmsCounter += 1
                }
                while residentsCounter < totalResidents!{
                    residentList.append(jsonResult["results"][counter]["residents"][residentsCounter].string!)
                    residentsCounter += 1
                }
                
                let newPlanet = Planets(name: name, rotationPeriod: rotationPeriod, orbitalPeriod: orbital, diameter: diameter, climate: climate, gravity: gravity, terrain: terrain, surfaceWater: surface, population: population, residents: residentList, films: filmList, urlString: url)
                
                PlanetList.append(newPlanet)
                counter += 1
            }
            tableView.reloadData()
            loaderSpinner.stopAnimating()
            imageSpinner.isHidden = true
            tableView.isHidden = false
            
        default:
            print("hay error en la matrix men")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "planetDetail" {
            let vc2 = segue.destination as! SinglePlanetDetailController
            vc2.urlString = self.nextScreenURL
            vc2.previousPage = endingForeignKey
            vc2.previousName =  nameForeign
        }
        if segue.identifier == "speciesDetail"{
            let vc2 = segue.destination as! SingleSpecieDetailController
            vc2.url = self.nextScreenURL
            vc2.previousPage = endingForeignKey
        }
        if segue.identifier == "filmDetail"{
            let vc2 = segue.destination as! SingleFilmDetailController
            vc2.url = self.nextScreenURL
            vc2.previousPage = endingForeignKey
        }
        if segue.identifier == "speciesDetail"{
            let vc2 = segue.destination as! SingleSpecieDetailController
            vc2.url = self.nextScreenURL
            vc2.previousPage = endingForeignKey
        }
        if segue.identifier == "vehicleDetail"{
            let vc2 = segue.destination as! SingleVehicleDetailViewController
            vc2.url = self.nextScreenURL
            vc2.previousPage = endingForeignKey
        }
    }
    
    

}
