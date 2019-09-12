//
//  ViewController.swift
//  UpMeDay
//
//  Created by MD. Amzad Hossain Arif on 26/8/19.
//  Copyright © 2019 MD. Amzad Hossain Arif. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON



class ViewController: UIViewController, CLLocationManagerDelegate, searchCityDelegate {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather"
    
    let APP_ID = "77c7aec71b33263e812664c9cb577a25"
    
    let locationManager = CLLocationManager()
    
    let weatherDataModel = WeatherDataModel()

    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var imageConditionIcon: UIImageView!
    @IBOutlet weak var buttonSwitch: UIButton!
    
    @IBOutlet weak var labelConditionInText: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self //ei class ta locationManager class er delegate
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1]

        if location.horizontalAccuracy > 0 {
            
            locationManager.stopUpdatingLocation()
            
            locationManager.delegate = nil
            
            let latitude = String(location.coordinate.latitude)
            
            let longitude = String(location.coordinate.longitude)
            
            print("Longitude: \(longitude), Latitude: \(latitude)")

            let paramss: [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            getWeatherData(url: weatherURL, params: paramss)

        }
        else {
            labelLocation.text = "Weather unavailable"
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error)
        
        labelLocation.text = "Location unavailable"
    }
    
    
    
    func getWeatherData(url: String, params: [String : String]){
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON{
            response in
            
            if response.result.isSuccess {
                
                let weatherJSON : JSON = JSON(response.result.value!)
                
                self.updateWeatherData(json: weatherJSON)
                
                print("Success! Got the weather Data")
                
                print(weatherJSON)
            }
            else{
                self.labelLocation.text = "Connection Issues"
                
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    
    
    func updateWeatherData(json : JSON) {
        
        let tempResult = json["main"]["temp"].double
        
        weatherDataModel.temperature = Int(tempResult! - 273.15)
        
        weatherDataModel.condition = json["weather"][0]["id"].intValue
        
        weatherDataModel.city = json["name"].stringValue
        
        weatherDataModel.country = json["sys"]["country"].stringValue
        
        weatherDataModel.conditionInText = json["weather"][0]["description"].stringValue
        
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
        
        weatherDataModel.fullName = weatherDataModel.updateFullForm(city: weatherDataModel.country)
        
        updateUiWithWeatherData()
    }
    
    
    
    func updateUiWithWeatherData() {
        
        labelLocation.text = weatherDataModel.city
        
        imageConditionIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        
        labelTemp.text = "\(weatherDataModel.temperature)°"
        
        labelCountry.text = "\(weatherDataModel.fullName)"
        
        labelConditionInText.text = "\(weatherDataModel.conditionInText)"
    }
    
    //NEXT two functions for sharing data secondView to firstView(this view)
    
    func userEnteredCityName(city: String) {
        
        let paramss : [String : String] = ["q": city, "appid": APP_ID]
        
        getWeatherData(url: weatherURL, params: paramss)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "oneTOtwo" {
            
            let destinationVC = segue.destination as! LocationSearchViewController
            
            destinationVC.delegate = self
        }
    }
    
    
    
}

