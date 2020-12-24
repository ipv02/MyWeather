

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
        case 200...232: return "storm"
        case 300...321: return "rain"
        case 500...531: return "rainCloud"
        case 600...622: return "snow"
        case 701...781: return "wind"
        case 800: return "sun"
        case 801...804: return "clouds"
        default: return "nosign"
        }
    }
}

struct Wind: Decodable {
    let speed: Double
}

