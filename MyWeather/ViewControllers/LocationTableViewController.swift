

import UIKit
import CoreData

class LocationTableViewController: UITableViewController {
    
    //MARK: - Properties
    private let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var locationWeather: [LocationWeather] = []
    
    //MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 80
        navigationItem.leftBarButtonItem = editButtonItem
        
        NetworkManager.shared.fetchCityWeather(forCity: "Moscow") { cityWeather in
            guard let cityWeather = cityWeather else {
                DispatchQueue.main.async {
                    self.errorAlertController()
                }
                return
            }
            DataManager.shared.cities.append(cityWeather)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        fetchData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DataManager.shared.cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationTableViewCell
        
        let cityWeather = DataManager.shared.cities[indexPath.row]
        cell.configureCell(for: cityWeather)
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentCityWeather = DataManager.shared.cities[indexPath.row]
        performSegue(withIdentifier: "detailWeather", sender: currentCityWeather)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let currentCity = DataManager.shared.cities.remove(at: sourceIndexPath.row)
        DataManager.shared.cities.insert(currentCity, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        DataManager.shared.cities.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailWeather" {
            let weatherVC = segue.destination as! WeatherViewController
            weatherVC.currentCityWeather = sender as? CityWeather
        }
    }

    //MARK: - IB Action
    @IBAction func addNewCity(_ sender: UIBarButtonItem) {
        
        addNewCityAlertController() { [unowned self] newCity in
            NetworkManager.shared.fetchCityWeather(forCity: newCity) { cityWeather in
                guard let cityWeather = cityWeather else {
                    DispatchQueue.main.async {
                        self.errorAlertController()
                    }
                    return
                }
                DataManager.shared.cities.append(cityWeather)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

//MARK: - Alert controller
extension LocationTableViewController {
    
    func addNewCityAlertController(completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: "Add New City", message: nil, preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default) { action in
            let textField = alertController.textFields?.first
            guard let newCity = textField?.text, !newCity.isEmpty else { return }
            let city = newCity.split(separator: " ").joined(separator: "%20")
            self.save(city)
            completion(city)
        }
        alertController.addTextField(configurationHandler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.view.tintColor = UIColor.black
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func errorAlertController() {
        let alertController = UIAlertController(title: "Wrong city!", message: "Try again", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true,completion: nil)
    }
}

//MARK: - Core Data
extension LocationTableViewController {
    
    private func save(_ cityName: String) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "LocationWeather",
                                                                 in: viewContext) else { return }
        guard let location = NSManagedObject(entity: entityDescription,
                                             insertInto: viewContext) as? LocationWeather else { return }
        location.city = cityName
        locationWeather.append(location)
        
        do {
            try viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    private func fetchData() {
        let fetchRequest: NSFetchRequest<LocationWeather> = LocationWeather.fetchRequest()
        
        do {
            locationWeather = try viewContext.fetch(fetchRequest)
        } catch let error {
            print(error)
        }
    }
}
