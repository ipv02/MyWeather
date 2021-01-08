

import Foundation

struct CityWeatherData: Decodable {
    let list: [List]
    let city: City
}

struct List: Decodable {
    let dt: Double
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let dt_txt: String
}

struct City: Decodable {
    let id: Int
    let name: String
    let timezone: Double
    let sunrise: Double
    let sunset: Double
}

struct Main: Decodable {
    let temp: Double
    var stringTemperature: String {
        String(format: "%.0f", temp)
    }
    let humidity: Int
}

struct Weather: Decodable {
    let id: Int
    let description: String
    let icon: String
    var iconString: String {
        switch id {
        case 200...232: return "cloud.bolt.rain"
        case 300...321: return "cloud.rain"
        case 500...531: return "cloud.sun.rain"
        case 600...622: return "cloud.snow"
        case 701...781: return "smoke"
        case 800: return "sun.max"
        case 801...804: return "cloud.sun"
        default: return "nosign"
        }
    }
}

struct Wind: Decodable {
    let speed: Double
}

