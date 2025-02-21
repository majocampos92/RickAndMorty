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
protocol CharactersUseCase {
    func getAllCharacters() -> AnyPublisher<[Character], Error>
}

struct CharactersUseCaseImpl: CharactersUseCase {
    private let repository: CharacterRepository

    init(repository: CharacterRepository) {
        self.repository = repository
    }
    
    func getAllCharacters() -> AnyPublisher<[Character], Error> {
        return repository.getAllCharacters()
    }
}
