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
    
    var displayWeatherData: WeatherData! {
        didSet {
            iconLabel.text = displayWeatherData.condition.icon
            currentTempLabel.text = "\(displayWeatherData.temperature)"
            highTempLabel.text = "\(displayWeatherData.highTemperature)º"
            lowTempLabel.text = "\(displayWeatherData.lowTemperature)º"
        }
    }
    
    var displayGeocodingData: GeocodingData! {
        didSet {
            locationLabel.text = displayGeocodingData.formattedAddress
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpDefaultUI()
    }
    
    //this function will give the UI some default whenever we first load the app
    func setUpDefaultUI() {
        locationLabel.text = ""
        iconLabel.text = "☀️"
        currentTempLabel.text = "Enter a location please!"
        highTempLabel.text = "-"
        lowTempLabel.text = "-"
    }

    
    //unwind action so we can unwind to this screen after retrieving data
    @IBAction func unwindToWeatherDisplay(segue: UIStoryboardSegue) {
        
    }

}

