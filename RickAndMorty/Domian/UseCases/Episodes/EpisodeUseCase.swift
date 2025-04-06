//
//  EpisodeUseCase.swift
//  RickAndMorty
//
//  Created by Maria Campos on 3/3/25.
//

import Moya
import CombineMoya
import Combine
import Foundation

protocol EpisodeUseCase {
    func getAllEpisodes() -> AnyPublisher<[Episode], Error>
}

struct EpisodeUseCaseImpl: EpisodeUseCase {
    private let repository: EpisodeRepository
    
    init(repository: EpisodeRepository) {
        self.repository = repository
    }
    
    func getAllEpisodes() -> AnyPublisher<[Episode], Error> {
        return repository.getAllEpisodes()
    }
}
