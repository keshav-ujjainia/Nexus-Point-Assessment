//
//  ViewController.swift
//  NexusWeather
//
//  Created by keshav ujjainia on 01/05/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var windDirection: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    
    var WeatherManager = weatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        WeatherManager.delegate = self
    }
    
    //MARK:- UITextfield Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let name = searchTextField.text {
            WeatherManager.fetchWeather(cityName: name)
        }
        searchTextField.text = ""
    }
    
    // Getting weather data from return key or search button
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
}

//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    
    // Method for updating UI
    func didUpdateWeather(_ weatherManager: weatherManager, weather: weatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = String(format: "%.2f", weather.temp) + "℃"
            self.weatherImg.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.city
            self.windSpeed.text = String(format: "%.2f", weather.windSpeed) + " kph"
            self.windDirection.text = weather.windDir
            self.weatherDescription.text = weather.condition
            self.feelsLike.text = "Feels like " + String(format: "%.2f", weather.feel) + "℃"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

