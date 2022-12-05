//
//  WeatherManager.swift
//  WeatherSwiftUI
//
//  Created by Gökçe Kahraman on 5.12.2022.
//

import Foundation
import CoreLocation

class WeatherManager{
    func getCurrentWeather(latitute: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody{
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitute)&lon=\(longitude)&appid=\("bb2ae32095ef6b44f2a94566f3eefb21")&units=metric") else {fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}

struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}
