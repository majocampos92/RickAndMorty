//
//  CharacterDetailModel.swift
//  RickAndMorty
//
//  Created by Maria Campos on 1/4/25.
//

import Foundation

// MARK: - CharacterDetailModel
struct CharacterDetailModel: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin, location: DetailItem
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - DetailItem
struct DetailItem: Codable {
    let name: String
    let url: String
}
