

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    func configureCollectionViewCell(for fewDaysWeather: List) {
        
        dateLabel.text = timeSetting(unixTimeValue: fewDaysWeather.dt,
                                     timeZone: "10800")
        weatherImage.image = UIImage(systemName: fewDaysWeather.weather.first!.iconString)
        temperatureLabel.text = fewDaysWeather.main.stringTemperature + "°"
    }
    
    func timeSetting(unixTimeValue: Double, timeZone: String) -> String {
        let dateAndTime = Date(timeIntervalSince1970: unixTimeValue)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E,ha"
        dateFormatter.timeZone = TimeZone(abbreviation: timeZone)
        let currentDateAndTime = dateFormatter.string(from: dateAndTime)
        return currentDateAndTime
    }
}
