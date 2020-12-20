//
//  LocationTableViewCell.swift
//  MyWeather
//
//  Created by Elena Igumenova on 16.12.2020.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func configureCell(for cityWeather: CityWeather) {
        
        cityLabel.text = cityWeather.cityName
        temperatureLabel.text = cityWeather.stringTemperature
        descriptionLabel.text = cityWeather.descriptionWeather
        weatherImage.image = UIImage(named: cityWeather.iconString)
        
//        DispatchQueue.global().async {
//            let stringUrl = " http://openweathermap.org/img/wn/\(cityWeather.iconWeather)@2x.png"
//            guard let imageUrl = URL(string: stringUrl) else { return }
//            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
//
//            DispatchQueue.main.async {
//                self.weatherImage.image = UIImage(data: imageData)
//            }
//        }
    }

}
