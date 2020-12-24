

import Foundation

struct CityWeather {
    
    let cityName: String
    
    let descriptionWeather: String
    
    let temperature: Double
    var stringTemperature: String {
        String(format: "%.0f", temperature)
    }
    
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
    
    let windSpeed: Double
    var stringWindSpeed: String {
        String(format: "%.1f", windSpeed)
    }
    
    let humidity: Int
    var humidityString: String {
        String(humidity)
    }
    
    let sunrise: Double
    var sunriseString: String {
        String(sunrise)
    }
    
    let sunset: Double
    var sunsetString: String {
        String(sunset)
    }
    
    let dt: Double
//    var dtString: String {
//        String(dt)
//    }
    
    let timeZone: Double
    var timeZoneString: String {
        String(timeZone)
    }
    
    var list: [List]
    
    init?(cityWeatherData: CityWeatherData) {
        cityName = cityWeatherData.city.name
        descriptionWeather = cityWeatherData.list.first?.weather.last?.description ?? ""
        temperature = cityWeatherData.list.first?.main.temp ?? 0.0
        idWeather = cityWeatherData.list.first?.weather.first?.id ?? 0
        iconWeather = cityWeatherData.list.first?.weather.first?.icon ?? ""
        windSpeed = cityWeatherData.list.first?.wind.speed ?? 0.0
        humidity = cityWeatherData.list.first?.main.humidity ?? 0
        sunrise = cityWeatherData.city.sunrise
        sunset = cityWeatherData.city.sunset
        dt = cityWeatherData.list.first?.dt ?? 0.0
        timeZone = cityWeatherData.city.timezone
        list = cityWeatherData.list
    }
}
