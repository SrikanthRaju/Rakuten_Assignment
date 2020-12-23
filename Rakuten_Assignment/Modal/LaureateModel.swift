//
//  LaureateModel.swift
//  Rakuten_Assignment
//
//  Created by Srikanth on 16/12/20.
//

import Foundation
import CoreLocation


struct LaureateModel {
    
    let id: Int64
    let awardCategory: String
    let diedDate: String
    let diedCity: String
    let bornCity: String
    let bornDate: String
    let lastName: String
    let firstName: String
    let motivation: String
    let location: Location
    let institutionCity: String
    let bornCountry: String
    let awardYear: String
    let diedCountry: String
    let institutionCountry: String
    let gender: String
    let institutionName: String
    
}

extension LaureateModel: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int64.self, forKey: .id)
        awardCategory = try container.decode(String.self, forKey: .awardCategory)
        diedDate = try container.decode(String.self, forKey: .diedDate)
        diedCity = try container.decode(String.self, forKey: .diedCity)
        bornCity = try container.decode(String.self, forKey: .bornCity)
        bornDate = try container.decode(String.self, forKey: .bornDate)
        lastName = try container.decode(String.self, forKey: .lastName)
        firstName = try container.decode(String.self, forKey: .firstName)
        motivation = try container.decode(String.self, forKey: .motivation)
        institutionCity = try container.decode(String.self, forKey: .institutionCity)
        bornCountry = try container.decode(String.self, forKey: .bornCountry)
        awardYear = try container.decode(String.self, forKey: .awardYear)
        diedCountry = try container.decode(String.self, forKey: .diedCountry)
        institutionCountry = try container.decode(String.self, forKey: .institutionCountry)
        gender = try container.decode(String.self, forKey: .gender)
        institutionName = try container.decode(String.self, forKey: .institutionName)
        location = try container.decode(Location.self, forKey: .location)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case gender
        case location
        case awardCategory = "category"
        case diedDate = "died"
        case diedCity = "diedcity"
        case bornCity = "borncity"
        case bornDate = "born"
        case lastName = "surname"
        case firstName = "firstname"
        case motivation
        case institutionCity = "city"
        case bornCountry = "borncountry"
        case awardYear = "year"
        case diedCountry = "diedcountry"
        case institutionCountry = "country"
        case institutionName = "name"
    }
}

extension LaureateModel: Equatable {
    static func == (lhs: LaureateModel, rhs: LaureateModel) -> Bool {
        return lhs.id == rhs.id
    }
}



//MARK: - Location Modal
struct Location {
    let latitude: Double
    let longitude: Double
    
}

extension Location: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
    }
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}


extension Location {

    /// Returns a CLLocation based ont he latitude/longitude passed in
    var mapLocation: CLLocation {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        return location
    }

    func distance(from location: Location) -> Double {
        let distanceInKilometers = mapLocation.distance(from: location.mapLocation) / 1000
        return distanceInKilometers
    }
}
