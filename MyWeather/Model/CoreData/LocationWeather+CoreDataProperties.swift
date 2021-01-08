

import Foundation
import CoreData


extension LocationWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationWeather> {
        return NSFetchRequest<LocationWeather>(entityName: "LocationWeather")
    }

    @NSManaged public var city: String?

}

extension LocationWeather : Identifiable {

}
