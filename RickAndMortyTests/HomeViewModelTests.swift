// HomeViewModelTests.swift
// RickAndMorty
//
// Created by Maria Campos on 27/3/25.
//

import XCTest
import Combine
import Foundation
@testable import RickAndMorty

final class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockCharacterUseCase: MockCharacterUseCase!
    var mockLocationUseCase: MockLocationUseCase!
    var mockEpisodeUseCase: MockEpisodeUseCase!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockCharacterUseCase = MockCharacterUseCase()
        mockLocationUseCase = MockLocationUseCase()
        mockEpisodeUseCase = MockEpisodeUseCase()
        
        viewModel = HomeViewModel(
            charactersUseCase: mockCharacterUseCase,
            locationUseCase: mockLocationUseCase,
            episodeUseCase: mockEpisodeUseCase
        )
    }
    
    override func tearDown() {
        viewModel = nil
        mockCharacterUseCase = nil
        mockLocationUseCase = nil
        mockEpisodeUseCase = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    // MARK: - CHARACTERS TESTS
    
    /// the successful fetching of characters
    func testFetchCharactersSuccess() {
        // Given
        let expectedCharacters = [
            Character(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                type: "Scientist",
                gender: "Male",
                origin: CharacterLocation(name: "Earth (C-137)",url: "https://rickandmortyapi.com/location/1"),
                location: CharacterLocation(name: "Citadel of Ricks",url: "https://rickandmortyapi.com/location/2"),
                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                episode: ["S01E01", "S02E05"],
                url: "https://rickandmortyapi.com/api/character/1",
                created: "2017-11-04T18:48:46.250Z"
            ),
            Character(
                id: 2,
                name: "Morty Smith",
                status: "Alive",
                species: "Human",
                type: "Student",
                gender: "Male",
                origin: CharacterLocation(name: "Earth (C-137)", url: "https://rickandmortyapi.com/location/1"),
                location: CharacterLocation(name: "Earth (C-137)", url: "https://rickandmortyapi.com/location/1"),
                image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                episode: ["S01E01", "S02E05"],
                url: "https://rickandmortyapi.com/api/character/2",
                created: "2017-11-04T18:50:21.651Z"
            )
        ]
        
        let response = CharactersModel(info: nil, results: expectedCharacters)
        mockCharacterUseCase.result = Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "Fetch characters successfully")
        
        // When
        viewModel.fecthCharacters()
        
        // Then
        viewModel.$characters
            .dropFirst()
            .sink { characters in
                if characters.count == expectedCharacters.count {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(viewModel.characters.count, expectedCharacters.count)
        XCTAssertEqual(viewModel.characters.first?.name, "Rick Sanchez")
    }
    
    /// verify that the error is handled correctly when fetching characters fails
    func testFetchCharactersFailure() {
        // Given
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
        mockCharacterUseCase.result = Fail(error: expectedError)
            .eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "Fetch characters fails")
        
        // When
        viewModel.fecthCharacters()
        
        // Then
        viewModel.$error
            .dropFirst()
            .sink { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - LOCATIONS TESTS
    
    /// the successful fetching of locations
    func testFetchLocationsSuccess() {
        // Given
        let expectedLocations = [
            Location(
                id: 1,
                name: "Earth (C-137)",
                type: "Planet",
                dimension: "Dimension C-137",
                residents: [],
                url: "https://rickandmortyapi.com/location/1",
                created: "2017-11-04T18:48:46.250Z"
            ),
            Location(
                id: 2,
                name: "Citadel of Ricks",
                type: "Space station",
                dimension: "unknown",
                residents: [],
                url: "https://rickandmortyapi.com/location/2",
                created: "2017-11-04T18:48:46.250Z"
            )
        ]
        
        let response = expectedLocations
        mockLocationUseCase.result = Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "Fetch locations successfully")
        
        // When
        viewModel.fetchLocations()
        
        // Then
        viewModel.$locations
            .dropFirst()
            .sink { locations in
                if locations.count == expectedLocations.count {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(viewModel.locations.count, expectedLocations.count)
        XCTAssertEqual(viewModel.locations.first?.name, "Earth (C-137)")
    }
    
    /// verify that the error is handled correctly when fetching locations fails
    func testFetchLocationsFailure() {
        // Given
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
        mockLocationUseCase.result = Fail(error: expectedError)
            .eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "Fetch locations fails")
        
        // When
        viewModel.fetchLocations()
        
        // Then
        viewModel.$error
            .dropFirst()
            .sink { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - EPISODES TESTS
    
    /// the successful fetching of episodes
    func testFetchEpisodesSuccess() {
        // Given
        let expectedEpisodes = [
            Episode(
                id: 1,
                name: "Pilot",
                airDate: "December 2, 2013",
                episode: "S01E01",
                characters: ["https://rickandmortyapi.com/character/1", "https://rickandmortyapi.com/character/2"],
                url: "https://rickandmortyapi.com/episode/1",
                created: "2017-11-04T18:48:46.250Z"
            ),
            Episode(
                id: 2,
                name: "Lawn Mower Dog",
                airDate: "December 9, 2013",
                episode: "S01E02",
                characters: ["https://rickandmortyapi.com/character/1"],
                url: "https://rickandmortyapi.com/episode/2",
                created: "2017-11-04T18:50:21.651Z"
            )
        ]
        
        let response = expectedEpisodes
        mockEpisodeUseCase.result = Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "Fetch episodes successfully")
        
        // When
        viewModel.fetchEpisodes()
        
        // Then
        viewModel.$episodes
            .dropFirst()
            .sink { episodes in
                if episodes.count == expectedEpisodes.count {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(viewModel.episodes.count, expectedEpisodes.count)
        XCTAssertEqual(viewModel.episodes.first?.name, "Pilot")
    }
    
    /// verify that the error is handled correctly when fetching episodes fails
    func testFetchEpisodesFailure() {
        // Given
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
        mockEpisodeUseCase.result = Fail(error: expectedError)
            .eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "Fetch episodes fails")
        
        // When
        viewModel.fetchEpisodes()
        
        // Then
        viewModel.$error
            .dropFirst()
            .sink { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - OTHERS TESTS
    
    /// ensures that data is not loaded multiple times if it has already been loaded
    func testLoadDataIfNeededDoesNotReloadDataAfterFirstLoad() {
        // Given
        XCTAssertFalse(viewModel.dataLoaded)
        
        let expectedCharacterCount = 2
        let expectedLocationCount = 3
        let expectedEpisodeCount = 1
        
        
        viewModel.characters = Array(repeating: CharacterDTO(id: 1, name: "Rick Sanchez", species: "Alive", image: ""), count: expectedCharacterCount)
        viewModel.locations = Array(repeating: LocationDTO(id: 1, name: "Earth (C-137)", type: "Planet", image: LocationImage.earth ), count: expectedLocationCount)
        viewModel.episodes = Array(repeating: EpisodeDTO(id: 1, name: "Lawn Mower Dog", episode: "S01E01", airDate: "December 3, 2013"), count: expectedEpisodeCount)
        
        // When
        viewModel.loadDataIfNeeded()
        
        // Then
        XCTAssertTrue(viewModel.dataLoaded)
        
        XCTAssertEqual(viewModel.characters.count, expectedCharacterCount)
        XCTAssertEqual(viewModel.locations.count, expectedLocationCount)
        XCTAssertEqual(viewModel.episodes.count, expectedEpisodeCount)
        
        let initialCharacterCount = viewModel.characters.count
        let initialLocationCount = viewModel.locations.count
        let initialEpisodeCount = viewModel.episodes.count
        
        // When
        viewModel.loadDataIfNeeded()
        
        // Then
        XCTAssertEqual(viewModel.characters.count, initialCharacterCount)
        XCTAssertEqual(viewModel.locations.count, initialLocationCount)
        XCTAssertEqual(viewModel.episodes.count, initialEpisodeCount)
    }
}
