

import UIKit

class WeatherViewController: UIViewController {
    
    //MARK: - Properties
    var currentCityWeather: CityWeather!
    var cityWeatherData: CityWeatherData!
    
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
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.layer.borderWidth = 0.5
        collectionView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        setupWeatherData()
        setupNavigationBar()
    }

    //MARK: - UI
    func setupWeatherData() {
        navigationItem.title = dateSetting(unixTimeValue: currentCityWeather.dt,
                                                  timeZone: currentCityWeather.timeZoneString)
        cityNameLabel.text? = currentCityWeather.cityName
        descriptionLabel.text = currentCityWeather.descriptionWeather
        temperatureLabel.text = currentCityWeather.stringTemperature + "°"
        iconImage.image = UIImage(systemName: currentCityWeather.iconString)
        
        windSpeedLabel.text = currentCityWeather.stringWindSpeed + " " + "m/s"
        humidityLabel.text = currentCityWeather.humidityString + " " + "%"
        
        sunriseLabel.text = timeSetting(unixTimeValue: currentCityWeather.sunrise,
                                        timeZone: currentCityWeather.timeZoneString)
        sunsetLabel.text = timeSetting(unixTimeValue: currentCityWeather.sunset,
                                       timeZone: currentCityWeather.sunsetString)
    }
    
    //MARK: - Setup bar button item
    private func setupNavigationBar() {
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
    
    //MARK: - Date and time
    func timeSetting(unixTimeValue: Double, timeZone: String) -> String {
        let dateAndTime = Date(timeIntervalSince1970: unixTimeValue)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = TimeZone(abbreviation: timeZone)
        dateFormatter.locale = Locale.autoupdatingCurrent
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
        return cell
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 80, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
