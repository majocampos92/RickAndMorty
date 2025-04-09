//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Maria Campos on 27/3/25.
//

import Foundation
import Combine

final class CharacterDetailViewModel: ObservableObject {
    @Published var characterDetail: CharacterDetailDTO = CharacterDetailDTO.placeholder
    @Published var episodes: [MultipleEpisodesDTO] = []
    @Published var ids: [String] = []
    @Published var error: Error?
    
    private let getCharacterDetailUseCase: GetCharacterDetailUseCase
    private let getMultipleEpisodesUseCase: GetMultipleEpisodesUseCase
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init(
        getCharacterDetailUseCase: GetCharacterDetailUseCase,
        getMultipleEpisodesUseCase: GetMultipleEpisodesUseCase
    ) {
        self.getCharacterDetailUseCase = getCharacterDetailUseCase
        self.getMultipleEpisodesUseCase = getMultipleEpisodesUseCase
    }
    
    func getCharacter(id: Int) {
        getCharacterDetailUseCase.getDetailCharacter(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let failure):
                    self.error = failure
                    print("❌ Error in get character: \(failure)")
                case .finished:
                    print("✅ Finish get character")
                    /// fectch for  a multiple episodes
                    self.getMultipleEpisodes()
                }
            }, receiveValue: { response in
                let id = response.episode
                    .compactMap { URL(string: $0)?.lastPathComponent }
                    .joined(separator: ",")
                
                self.ids.append(id)
                
                self.characterDetail = CharacterDetailDTO(
                    id: response.id,
                    name: response.name,
                    status: response.status,
                    specie: response.species,
                    gender: response.gender,
                    image: response.image,
                    origin: response.origin.name,
                    location: response.location.name
                )
            })
            .store(in: &cancellables)
    }
    
    func getMultipleEpisodes() {
        ///`.joined()` simply converts it into a clean String eg.: 1,2,3..., removing the [" "]
        getMultipleEpisodesUseCase.getMultipleEpisodesUseCase(ids: self.ids.joined())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("✅ Finish get episodes in character detail")
                case .failure(let failure):
                    self.error = failure
                    print("❌ Error in get epidodes in character detail: \(failure)")
                }
            }, receiveValue: { response in
                print("\(response)")
                response.forEach { item in
                    self.episodes.append(MultipleEpisodesDTO(id: item.id, name: item.name, episode: item.episode))
                }
            })
            .store(in: &cancellables)
    }
}

// MARK: - Extensions
extension CharacterDetailViewModel {
    static func make() -> CharacterDetailViewModel {
        CharacterDetailViewModel(
            getCharacterDetailUseCase: Injector.resolve(GetCharacterDetailUseCase.self),
            getMultipleEpisodesUseCase: Injector.resolve(GetMultipleEpisodesUseCase.self)
        )
    }
}
