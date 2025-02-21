//
//  CharacterDTO.swift
//  RickAndMorty
//
//  Created by Maria Campos on 21/2/25.
//

import Foundation

struct CharacterDTO: Codable {
    let id: Int
    let name: String
    let species: String
    let image: String
}
