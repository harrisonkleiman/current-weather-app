//
//  WeatherInfo.swift
//  CurrentWeatherApp
//
//  Created by Ivan Ramirez on 2/3/22.
//

import Foundation

    struct WeatherInfo: Decodable {

        // coord
        var coord: Coord
        // name
        var name: String
        // weather
        var weather: [Weather]
        // main
        var main: Main
    }

    struct Coord: Decodable {
        var lon: Double
        var lat: Double
    }
 
    struct Weather: Decodable {
    var main: String
    var description: String
  }

    struct Main: Decodable {
    var temp: Double
    var tempMin: Double
    var tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
