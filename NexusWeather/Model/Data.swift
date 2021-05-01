//
//  Data.swift
//  NexusWeather
//
//  Created by keshav ujjainia on 01/05/21.
//

import Foundation

//Define structures for decoding needed data from url
struct weatherData: Codable {
    let location: Location
    let current: Current
}

struct Location: Codable {
    let name: String
}

struct Current: Codable {
    let temp_c: Double
    let feelslike_c: Double
    let condition: Condition
    let wind_kph : Double
    let wind_dir : String
}

struct Condition: Codable {
    let text: String
    let code: Int
}
