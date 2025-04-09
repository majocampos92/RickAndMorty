//
//  MultipleEpisodesModelElement.swift
//  RickAndMorty
//
//  Created by Maria Campos on 8/4/25.
//

import Foundation

// MARK: - MultipleEpisodesModelElement
struct MultipleEpisodesModel: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
