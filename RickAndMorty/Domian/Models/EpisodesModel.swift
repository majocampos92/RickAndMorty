//
//  EpisodesModel.swift
//  RickAndMorty
//
//  Created by Maria Campos on 3/3/25.
//

import Foundation

// MARK: - EpisodesModel
struct EpisodesModel: Codable {
    let info: Info?
    let results: [Episode]?
}

// MARK: - Episode
struct Episode: Codable {
    let id: Int?
    let name, airDate, episode: String?
    let characters: [String]?
    let url: String?
    let created: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
