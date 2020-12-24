

import UIKit

class WeatherViewController: UIViewController {
    
    //MARK: - Properties
    let unixTimeMoscow = 1608672734
    var currentCityWeather: CityWeather!
    var cityWeatherData: CityWeatherData!
    let sectionInserts = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    //MARK: - IB Outlet
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        updateInterface()
        setupNavigationBar()

    }

    //MARK: - UI
    func updateInterface() {
        navigationItem.title = dateSetting(unixTimeValue: currentCityWeather.dt,
                                                  timeZone: currentCityWeather.timeZoneString)
        cityNameLabel.text? = currentCityWeather.cityName
        descriptionLabel.text = currentCityWeather.descriptionWeather
        temperatureLabel.text = currentCityWeather.stringTemperature + "°"
        iconImage.image = UIImage(named: currentCityWeather.iconString)
        
        windSpeedLabel.text = currentCityWeather.stringWindSpeed + " " + "m/s"
        humidityLabel.text = currentCityWeather.humidityString + " " + "%"
        
        sunriseLabel.text = timeSetting(unixTimeValue: currentCityWeather.sunrise,
                                        timeZone: currentCityWeather.timeZoneString)
        sunsetLabel.text = timeSetting(unixTimeValue: currentCityWeather.sunset,
                                       timeZone: currentCityWeather.sunsetString)
    }
    
    //MARK: - Setup navigation bar and button
    private func setupNavigationBar() {
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            topItem.backBarButtonItem?.tintColor = .black
        }
    }
    
    //MARK: - Date and time
    func timeSetting(unixTimeValue: Double, timeZone: String) -> String {
        let dateAndTime = Date(timeIntervalSince1970: unixTimeValue)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = TimeZone(abbreviation: timeZone)
        //dateFormatter.locale = Locale.autoupdatingCurrent
        let currentDateAndTime = dateFormatter.string(from: dateAndTime as Date)
        return currentDateAndTime
    }
    
    func dateSetting(unixTimeValue: Double, timeZone: String) -> String {
        let dateAndTime = Date(timeIntervalSince1970: unixTimeValue)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.timeZone = TimeZone(abbreviation: timeZone)
        dateFormatter.locale = Locale.autoupdatingCurrent
        let currentDateAndTime = dateFormatter.string(from: dateAndTime as Date)
        return currentDateAndTime
    }
}

//MARK: - Extension
extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currentCityWeather.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weather", for: indexPath) as! WeatherCollectionViewCell
        let fewDaysWeather = currentCityWeather.list[indexPath.item]
        cell.configureCollectionViewCell(for: fewDaysWeather)
        
        //cell.layer.borderWidth = 1
        
        return cell
    }
    
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
