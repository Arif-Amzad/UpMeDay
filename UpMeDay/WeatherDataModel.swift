//
//  WeatherDataModel.swift
//  UpMeDay
//
//  Created by MD. Amzad Hossain Arif on 27/8/19.
//  Copyright © 2019 MD. Amzad Hossain Arif. All rights reserved.
//

import Foundation

class WeatherDataModel {
    var temperature: Int = 0
    var condition: Int = 0
    var city: String = ""
    var weatherIconName: String = ""
    var country: String = ""
    var conditionInText: String = ""
    var fullName: String = ""
    
    func updateFullForm(city: String) -> String {
        switch(city) {
        case "BD" :
            return "Bangladesh"
            
        case "US" :
            return "United States"
            
        case "IN" :
            return "India"
            
        case "PK" :
            return "Pakistan"
            
        case "UK" :
            return "United Kingdom"
            
        default:
            return "loading"
        }
    }
    
    func updateWeatherIcon(condition: Int) -> String {
        switch (condition) {
        case 0...300 :
            return "tstorm1"
            
        case 301...500 :
            return "light_rain"
            
        case 501...600 :
            return "shower3"
            
        case 601...700 :
            return "snow4"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "tstorm3"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy2"
            
        case 900...903, 905...1000  :
            return "tstorm3"
            
        case 903 :
            return "snow5"
            
        case 904 :
            return "sunny"
            
        default:
            return "Cloud-Refresh"
        }
    }
}
