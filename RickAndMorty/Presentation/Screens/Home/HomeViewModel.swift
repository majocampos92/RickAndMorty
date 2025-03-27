//
//  HomeViewModel.swift
//  RickAndMorty
//
//  Created by Maria Campos on 21/2/25.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    // MARK: - Properties
    @Published var characters: [CharacterDTO] = []
    @Published var locations: [LocationDTO] = []
    @Published var episodes: [EpisodeDTO] = []
    @Published var dataLoaded = false
    @Published var error: Error?

    // MARK: Use cases
    private let charactersUseCase: CharacterUseCase
    private let locationsUseCase: LocationUseCase
    private let episodesUseCase: EpisodeUseCase
    
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization
    init(
        charactersUseCase: CharacterUseCase,
        locationUseCase: LocationUseCase,
        episodeUseCase: EpisodeUseCase
    ) {
        self.charactersUseCase = charactersUseCase
        self.locationsUseCase = locationUseCase
        self.episodesUseCase = episodeUseCase
    }
    
    // MARK: Fetch all Characters
    func fecthCharacters() {
        charactersUseCase.getAllCharacters(page: 1)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let failure):
                    self.error = failure
                    print("❌ Error in get all characters: \(failure)")
                case .finished:
                    print("✅ Finish get all characters")
                }
            }, receiveValue: { response in
                response.results?.prefix(5).forEach { item in
                    self.characters.append(
                        CharacterDTO(
                            id: item.id ?? 0,
                            name: item.name ?? "Unknown",
                            species: item.species ?? "Unknown",
                            image: item.image ?? "Unknown"
                        )
                    )
                }
            })
            .store(in: &cancellables)
    }
    
    // MARK: Fetch all Locations
    func fetchLocations() {
        locationsUseCase.getAllLocations()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("✅ Finish get all locations")
                case .failure(let failure):
                    self.error = failure
                    print("❌ Error in get all locations \(failure)")
                }
            }, receiveValue: { response in
                response.prefix(5).forEach { item in
                    let locationImage = LocationImageMapper.image(for: item.name ?? "Unknown")
                    
                    self.locations.append(
                        LocationDTO(
                            id: item.id ?? 0,
                            name: item.name ?? "Unknown",
                            type: item.type ?? "Unknown",
                            image: locationImage
                        )
                    )
                }
            })
            .store(in: &cancellables)
    }
    
    // MARK: Fetch all Episodes
    func fetchEpisodes() {
        episodesUseCase.getAllEpisodes()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("✅ Finish get all episodes")
                case .failure(let failure):
                    self.error = failure
                    print("❌ Error in get all episodes \(failure)")

                }
            }, receiveValue: { response in
                response.prefix(3).forEach { item in
                    self.episodes.append(
                        EpisodeDTO(
                            id: item.id ?? 0,
                            name: item.name ?? "Unknown",
                            episode: item.episode ?? "Unknown",
                            airDate: item.airDate ??  "Unknown"
                        )
                    )
                }
            })
            .store(in: &cancellables)
    }
    
    func loadDataIfNeeded() {
        if !dataLoaded {
            fecthCharacters()
            fetchLocations()
            fetchEpisodes()
            dataLoaded = true
        }
    }
}

// MARK: - Extensions
extension HomeViewModel {
    static func make() -> HomeViewModel {
        HomeViewModel(
            charactersUseCase: Injector.resolve(CharacterUseCase.self),
            locationUseCase: Injector.resolve(LocationUseCase.self),
            episodeUseCase: Injector.resolve(EpisodeUseCase.self)
        )
    }
}
