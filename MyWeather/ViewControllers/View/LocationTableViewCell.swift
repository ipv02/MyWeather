

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    

    func configureCell(for cityWeather: CityWeather) {
        
        cityLabel.text = cityWeather.cityName
        temperatureLabel.text = cityWeather.stringTemperature + "°C"
        descriptionLabel.text = cityWeather.descriptionWeather
        weatherImage.image = UIImage(named: cityWeather.iconString)
        
    }
}
