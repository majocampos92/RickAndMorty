//
//  CharactersModel.swift
//  RickAndMorty
//
//  Created by Maria Campos on 21/2/25.
//

import Foundation

// MARK: - CharactersModel
struct CharactersModel: Codable {
    let info: Info?
    let results: [Character]?
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

// MARK: - Character
struct Character: Codable {
    let id: Int?
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}
