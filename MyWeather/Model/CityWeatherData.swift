

import Foundation

struct CityWeatherData: Decodable {
    let list: [List]
    let city: City
}

struct List: Decodable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let dt_txt: String
}

struct City: Decodable {
    let id: Int
    let name: String
    let timezone: Int
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    let description: String
    let icon: String
}

struct Wind: Decodable {
    let speed: Double
}

