//
//  WeatherManager.swift
//  NexusWeather
//
//  Created by keshav ujjainia on 01/05/21.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: weatherManager, weather: weatherModel)
    func didFailWithError(error: Error)
}

struct weatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.weatherapi.com/v1/current.json?key=66217b0017b04fa986a130528210105"
    
    
    //MARK:- Featching Weather Data Method
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)&aqi=yes"
        performRequest(with: urlString)
    }
    
    //MARK:- Perform a URLSession Request
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    //MARK:- Decode Data from JSON Decoder
    
    func parseJSON(_ weather: Data) -> weatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedWeatherData = try decoder.decode(weatherData.self, from: weather)
            let cityName = decodedWeatherData.location.name
            let decodedConditionID = decodedWeatherData.current.condition.code
            let windDirection = decodedWeatherData.current.wind_dir
            let windkph = decodedWeatherData.current.wind_kph
            let temperature = decodedWeatherData.current.temp_c
            let decodedCondition = decodedWeatherData.current.condition.text
            let feelsLike = decodedWeatherData.current.feelslike_c
            
            let model = weatherModel(city: cityName, temp: temperature, windSpeed: windkph, windDir: windDirection, conditionID: decodedConditionID, condition: decodedCondition, feel: feelsLike)
            return model
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
