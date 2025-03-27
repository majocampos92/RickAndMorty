//
//  CharactersUseCase.swift
//  RickAndMorty
//
//  Created by Maria Campos on 21/2/25.
//

import Moya
import CombineMoya
import Combine
import Foundation

// MARK: - Protocols
protocol CharacterUseCase {
    func getAllCharacters(page: Int) -> AnyPublisher<CharactersModel, Error>
}

struct CharactersUseCaseImpl: CharacterUseCase {
    private let repository: CharacterRepository

    init(repository: CharacterRepository) {
        self.repository = repository
    }
    
    func getAllCharacters(page: Int) -> AnyPublisher<CharactersModel, Error> {
        return repository.getAllCharacters(page: page)
    }
}
