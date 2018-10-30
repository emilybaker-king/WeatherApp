//
//  APIManager.swift
//  WeatherApp
//
//  Created by Emily Baker-King on 10/29/18.
//  Copyright © 2018 Emily Baker-King. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class APIManager {
    
    //Base URL for the Dark Sky API
    private let darkSkyURL = "https://api.darksky.net/forecast/"
    
    //Base URL for the Google Geocoding API
    private let googleBaseURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
    
    //Instance of the APIKeys struct in APIKeys
    private let apikeys = APIKeys()
    
    
    //Enum containing different errors we could get from trying to connect to an API
    enum APIErrors: Error {
        case noData
        case noResponse
        case invalidData
    }
    
    
    //Call the Dark Sky API to get a weather icon
    func getWeather(latitude: Double, longitude: Double, onCompletion: @escaping (WeatherData?, Error?) -> Void) {
        
        let url = darkSkyURL + apikeys.darkSkyKey + "/" + "\(latitude)" + "," + "\(longitude)"
        
        let request = Alamofire.request(url)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                print(json)
                
                //If the JSON can be converted into Weather data, call the completion closure by passing in the weather data and nil for the error
                if let weatherData = WeatherData(json: json) {
                    onCompletion(weatherData, nil)
                } else {
                    onCompletion(nil, APIErrors.invalidData)
                }
            case .failure(let error):
                onCompletion(nil, error)
            }
        }
    }
    
    
    //Call the GoogleGeocoding API to get info for latitude and longitude
    //Attempt to geocode the address that is passed in. Afterwards call the onCompletion closure by passing in geocoding data for an error.
    func geocode(address: String, onCompletion: @escaping (GeocodingData?, Error?) -> Void) {
        
        //The URL for our Google Geocoding API call
        let url = googleBaseURL + address + "&key=" + apikeys.googleKey
        
        //An Alamofire request made from that URL
        let request = Alamofire.request(url)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                print(json)
                
                //If the JSON can be converted into Geocoding data, call the completion closure by passing in the geocoding data and nil for the error
                if let geocodingData = GeocodingData(json: json) {
                    onCompletion(geocodingData, nil)
                } else {
                    onCompletion(nil, APIErrors.invalidData)
                }
            case .failure(let error):
                onCompletion(nil, error)
            }
        }
    }
    
}
