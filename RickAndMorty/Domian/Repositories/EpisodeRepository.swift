//
//  EpisodeRepository.swift
//  RickAndMorty
//
//  Created by Maria Campos on 3/3/25.
//

import Foundation
import Combine

protocol EpisodeRepository {
    func getAllEpisodes() -> AnyPublisher<[Episode], Error>
}
