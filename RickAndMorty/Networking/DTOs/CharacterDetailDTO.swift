//
//  CharacterDetailDTO.swift
//  RickAndMorty
//
//  Created by Maria Campos on 8/4/25.
//

import Foundation

struct CharacterDetailDTO: Codable {
    let id: Int
    let name: String
    let status: String
    let specie: String
    let gender: String
    let image: String
    let origin: String
    let location: String
    
    static let placeholder = CharacterDetailDTO(
        id: 0,
        name: "Unknown",
        status: "Unknown",
        specie: "Unknown",
        gender: "Unknown",
        image: "https://example.com/placeholder.png",
        origin: "Unknown Origin",
        location: "Unknown Location"
    )
}
