//
//  MockCharacterUseCase.swift
//  RickAndMorty
//
//  Created by Maria Campos on 27/3/25.
//

import XCTest
import Combine
@testable import RickAndMorty

// MARK: Characters
final class MockCharacterUseCase: CharacterUseCase {
    var result: AnyPublisher<CharactersModel, Error> = Just(CharactersModel(info: nil, results: []))
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    
    func getAllCharacters(page: Int) -> AnyPublisher<CharactersModel, Error> {
        return result
    }
}

// MARK: Locations
final class MockLocationUseCase: LocationUseCase {
    var result: AnyPublisher<[Location], Error> = Just([])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    
    func getAllLocations() -> AnyPublisher<[Location], Error> {
        return result
    }
}

// MARK: Episodes
final class MockEpisodeUseCase: EpisodeUseCase {
    var result: AnyPublisher<[Episode], Error> = Just([])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    
    func getAllEpisodes() -> AnyPublisher<[Episode], Error> {
        return result
    }
}
