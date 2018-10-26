//
//  WeatherDisplayViewController.swift
//  WeatherApp
//
//  Created by Emily Baker-King on 10/24/18.
//  Copyright © 2018 Emily Baker-King. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class WeatherDisplayViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpDefaultUI()
        
        
        let apiKeys = APIKeys()
        
        let darkSkyURL = "https://api.darksky.net/forecast/"
        let darkSkyKey = apiKeys.darkSkyKey
        let latitude = "37.004842"
        let longitude = "-85.925876"
        
        let url = darkSkyURL + darkSkyKey + "/" + latitude + "," + longitude
        
        let request = Alamofire.request(url)
        
        //carry out the request here
        request.responseJSON { response in
            //switch based on result of the request
            switch response.result {
            case .success(let value):
                //if our request succeeds, take the value and convert it into a JSON object
                let json = JSON(value)
                //print out the JSON object
                print(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let googleBaseURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
        
        let googleRequestURL = googleBaseURL + "Glasgow,+Kentucy" + "&key=" + apiKeys.googleKey
        
        let googleRequest = Alamofire.request(googleRequestURL)
        
        //carry out request here
        googleRequest.responseJSON { response in
            //switching based on result of the request
            switch response.result {
            case .success(let value):
                //if our request succeeds, take the value and convert it into a JSON object
                let json = JSON(value)
                //print out the JSON object
                print(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //this function will give the UI some default whenever we first load the app
    func setUpDefaultUI() {
        locationLabel.text = ""
        iconLabel.text = "☀️"
        currentTempLabel.text = "Enter a location please!"
        highTempLabel.text = "-"
        lowTempLabel.text = "-"
    }


}

