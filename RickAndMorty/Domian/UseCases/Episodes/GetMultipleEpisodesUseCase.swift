//
//  GetMultipleEpisodesUseCase.swift
//  RickAndMorty
//
//  Created by Maria Campos on 8/4/25.
//

import Foundation
import Combine

protocol GetMultipleEpisodesUseCase {
    func getMultipleEpisodesUseCase(ids: String) -> AnyPublisher<[MultipleEpisodesModel], Error>
}

struct GetMultipleEpisodesUseCaseImpl: GetMultipleEpisodesUseCase {
    private let repository: EpisodeRepository
    
    init(repository: EpisodeRepository) {
        self.repository = repository
    }
    
    func getMultipleEpisodesUseCase(ids: String) -> AnyPublisher<[MultipleEpisodesModel], Error> {
        return repository.getMultipleEpisodes(ids: ids)
    }
}
