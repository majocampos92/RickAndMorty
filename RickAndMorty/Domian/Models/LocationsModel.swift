//
//  LocationsModel.swift
//  RickAndMorty
//
//  Created by Maria Campos on 28/2/25.
//

import Foundation

// MARK: - LocationsModel
struct LocationsModel: Codable {
    let info: Info?
    let results: [Location]?
}

// MARK: - Result
struct Location: Codable {
    let id: Int?
    let name, type, dimension: String?
    let residents: [String]?
    let url: String?
    let created: String?
}
