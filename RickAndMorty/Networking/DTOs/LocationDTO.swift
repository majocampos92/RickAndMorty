//
//  LocationDTO.swift
//  RickAndMorty
//
//  Created by Maria Campos on 28/2/25.
//

import Foundation

struct LocationDTO: Codable {
    let id: Int
    let name: String
    let type: String
    let image: LocationImage
}

enum LocationImage: String, Codable {
    case citadelOfRicks = "citadel_of_ricks"
    case earth = "earth_c_137"
    case immortalityFieldResort = "immortality_field_resort"
    case postApocalypticEarth = "post_apocalyptic_earth"
    case purgePlanet = "purge_planet"
    case venzenulon7 = "venzenulon_7"
    case abadango = "abadango"
    case anatomyPark = "anatomy_park"
    case worldendersLair = "worldenders_lair"
    case interdimensionalCable = "interdimensional_cable"
    case unknown = "unknown_placeholder"
}

struct LocationImageMapper {
    static let mapping: [String: LocationImage] = [
        "Earth (C-137)": .earth,
        "Citadel of Ricks": .citadelOfRicks,
        "Immortality Field Resort": .immortalityFieldResort,
        "Post Apocalyptic Earth": .postApocalypticEarth,
        "Venzenulon 7": .venzenulon7,
        "Purge Planet": .purgePlanet,
        "Abadango": .abadango,
        "Anatomy Park": .anatomyPark,
        "Worldender's lair": .worldendersLair,
        "Interdimensional Cable": .interdimensionalCable,
        "Unknown": .unknown
    ]
    
    static func image(for locationName: String) -> LocationImage {
        return mapping[locationName] ?? .unknown
    }
}
