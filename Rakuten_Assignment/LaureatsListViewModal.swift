//
//  LaureatsListViewModal.swift
//  Rakuten_Assignment
//
//  Created by Srikanth on 16/12/20.
//

import Foundation

struct LaureatCellDTO {
    let laureateName: String
    let awardCategory: String
    let awardYear: String
    let country: String
    
    init(_ modal: LaureateModel) {
        laureateName = modal.firstName + " " + modal.lastName
        awardYear = modal.awardYear
        country = modal.institutionCountry
        awardCategory = modal.awardCategory
    }
}



class LaureatsListViewModal {
    
    private let year: String
    private let latitude: Double
    private let longitude: Double
    private let selectedLocation: Location
    private var modals = [LaureatCellDTO]()
    
    var reloadList: (() -> Void)?

    
    init(with year: String, latitude: Double, longitude: Double) {
        
        self.year = year
        self.latitude = latitude
        self.longitude = longitude
        
        selectedLocation = Location(latitude: latitude, longitude: longitude)

        
        loadData()
    }
    
    
    
    func nobelLaureatsCount() -> Int {
        return modals.count
    }
    
    func nobelLaureats(at index: Int) -> LaureatCellDTO {
        return modals[index]
    }

    
    func loadData() {
      let resource = JSONBundleFile(withName: "nobel-prize-laureates")
      let laureatesParser = LaureatesParser(resource: resource, parser: LaureateJSONParser())
      laureatesParser.parse { [weak self] (result) in
        switch result {
          case .success(let model):
            guard let dataModels = self?.getHeighestRankedNobelLaureates(from: model) else { return }
            self?.modals = dataModels.map({ LaureatCellDTO($0) })
            DispatchQueue.main.async { [weak self] in
                self?.reloadList?()
            }
          case .failure(let error):
            print(error.localizedDescription)
        }
      }
    }
    
    
    
}


extension LaureatsListViewModal {
    
    /// Generates List of `Laureates` for given `year` `latitude` and  `longitude`
    /// - Parameters:
    ///    - model: A decodable object of type `LaureatesModel` which contains the metadata info of individual laureate.
    ///    - forYear: A string that contains input year.
    ///    - forLatitude: A double that contains input latitude.
    ///    - forLongitude: A double that contains input longitude.
    /// - Returns: List of Laureates .
    func getHeighestRankedNobelLaureates(from model: [LaureateModel]) -> [LaureateModel] {
        
        var listFilteredByInputYear = [LaureateModel]()
        
        var filteredLaureatesList = [LaureateModel]()
        
        listFilteredByInputYear.append(contentsOf: model.filter({ $0.awardYear == year }))
        
        /// This has to be in the search result as this is filtered by inpur year and it should be of heighest rank.
        filteredLaureatesList.append(contentsOf: listFilteredByInputYear)
        
        /// Array of countries from the array filtered by input year.
        let listOfCountriesFromListFilteredByYear = listFilteredByInputYear.compactMap({
            $0.institutionCountry
        })
        
        /// Returns country which is repeated most or has heighest rank.
        guard let heighestRankedCountry = mostFrequentCountry(countryList: listOfCountriesFromListFilteredByYear) else {
            return listFilteredByInputYear
        }
        
        ///List of Lureates from the model filtered by heighest ranked country.
        let listFilteredBasedOnLocation = model.filter({
            return $0.institutionCountry == heighestRankedCountry
        })
        
        /// List of Laureates filtered by input location.
        let listOfLaureatesBasedOnLatLong = model.filter({
            return $0.location.latitude == latitude && $0.location.longitude == longitude
        })
        
        ///List of Laureates based on input Latitude and Longitude.
        listOfLaureatesBasedOnLatLong.forEach({
            if !filteredLaureatesList.contains($0) {
                filteredLaureatesList.append($0)
            }
        })
        
        /// Add Remaing Laureates from List filtered by Heighest Rank Country.
        if filteredLaureatesList.count < 20 {
            for aModel in listFilteredBasedOnLocation {
                if filteredLaureatesList.count == 20 {
                    break
                } else {
                    filteredLaureatesList.append(aModel)
                }
            }
        }
        
        return filteredLaureatesList
    }
    
    
    func mostFrequentCountry(countryList: [String]) -> String? {
        
        let counts = countryList.reduce(into: [:]) { $0[$1, default: 0] += 1 }
        
        if let (value, _) = counts.max(by: { $0.1 < $1.1 }) {
            return value
        }
        return nil
    }
}
