

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCityWeather(forCity cityName: String, completion: @escaping (CityWeather?) -> Void) {
        
        let apiKey = "b3f808eb36ba979691b75a75d1c68496"
        
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&units=metric&appid=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            //decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let cityWeatherData = try decoder.decode(CityWeatherData.self, from: data)
                guard let cityWeather = CityWeather(cityWeatherData: cityWeatherData) else { return }
                completion(cityWeather)
            } catch let error {
                print(error)
            }
        }.resume()
    }
        
}
