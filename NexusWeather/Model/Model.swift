//
//  Model.swift
//  NexusWeather
//
//  Created by keshav ujjainia on 01/05/21.
//

import Foundation

struct weatherModel {
    
    // Declare weather model constants & variables
    let city: String
    let temp: Double
    let windSpeed: Double
    let windDir : String
    let conditionID: Int
    let condition: String
    let feel: Double
    
    var conditionName: String {
        switch conditionID {
        case 1000...1031:
            return "sun.max"
        case 1063...1088:
            return "cloud.bolt"
        case 1114...1172:
            return "cloud.drizzle"
        case 1080...1202:
            return "cloud.rain"
        case 1203...1238:
            return "cloud.snow"
        case 1240...1282:
            return "cloud.rain"
        default:
            return "cloud.bolt"
        }
    }
}
