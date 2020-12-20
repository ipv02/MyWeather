

import Foundation

struct CityWeather {
    
    let cityName: String
    
    let descriptionWeather: String
    
    let temperature: Double
    var stringTemperature: String {
        String(format: "%.0f", temperature)
    }
    
//    let idWeather: Int
//    var stringIdWeather: String {
//        String(format: "%.0f", idWeather)
//    }
    
    let idWeather: Int
    var iconString: String {
        switch idWeather {
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
    
    let iconWeather: String
    
    init?(cityWeatherData: CityWeatherData) {
        cityName = cityWeatherData.city.name
        descriptionWeather = cityWeatherData.list.first?.weather.last?.description ?? ""
        temperature = cityWeatherData.list.last?.main.temp ?? 0.0
        idWeather = cityWeatherData.list.first?.weather.first?.id ?? 0
        iconWeather = cityWeatherData.list.first?.weather.first?.icon ?? ""
    }
}
