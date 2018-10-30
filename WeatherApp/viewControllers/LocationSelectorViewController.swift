//
//  LocationSelectorViewController.swift
//  WeatherApp
//
//  Created by Emily Baker-King on 10/26/18.
//  Copyright © 2018 Emily Baker-King. All rights reserved.
//

import UIKit

class LocationSelectorViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    //Instance of the API Manager class so we can make API calls on this screen
    let apiManager = APIManager()
    
    var geocodingData: GeocodingData?
    var weatherData: WeatherData?
    
    //if something goes wrong with one of the API codes, call this to take handle it
    func handleError() {
        geocodingData = nil
        weatherData = nil
    }
    
    func retrieveGeocodingData(searchAddress: String) {
        
        apiManager.geocode(address: searchAddress) {
            (geocodingData, error) in
            //if we recieve an error, print out the error's localized description, call the handleError function, and return
            if let recievedError = error {
                print(recievedError.localizedDescription)
                self.handleError()
                return
            }
            
            //if we recieved geocoding data, assign it to the geocoding property and then make a Dark Sky call
            if let recievedData = geocodingData {
                self.geocodingData = recievedData
                // use that data to make a dark sky call
                self.retrieveWeatherData(latitude: recievedData.latitude, longitude: recievedData.longitude)
            } else {
                self.handleError()
                return
            }
        }
    }
    
    
    func retrieveWeatherData(latitude: Double, longitude: Double) {
        
        apiManager.getWeather(latitude: latitude, longitude: longitude) { (weatherData, error) in
            if let receivedError = error {
                print(receivedError.localizedDescription)
                self.handleError()
                return
            }
            
            if let receivedData = weatherData {
                self.weatherData = receivedData
                //TODO: This is where we need to segue back to the main screen
                self.performSegue(withIdentifier: "unwindToWeatherDisplay", sender: self)
            } else {
                self.handleError()
                return
            }
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: " ", with: "+") else {
            return
        }
        retrieveGeocodingData(searchAddress: searchAddress)
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? WeatherDisplayViewController, let retrievedGeocodingData = geocodingData, let retrievedWeatherData = weatherData {
            destinationVC.displayGeocodingData = retrievedGeocodingData
            destinationVC.displayWeatherData = retrievedWeatherData
        }
        
    }
 

}
