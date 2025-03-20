//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Maria Campos on 18/3/25.
//

import Foundation
import Combine

final class CharactersViewModel: ObservableObject {
    // MARK: - Properties
    @Published var characters: [CharacterDTO] = []
    @Published var dataLoaded = false
    @Published var error: Error?

    // MARK: Use cases
    private let charactersUseCase: CharacterUseCase
    
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization
    init(charactersUseCase: CharacterUseCase) {
        self.charactersUseCase = charactersUseCase
    }
    
    // MARK: Fetch all Characters
    func fecthCharacters() {
        charactersUseCase.getAllCharacters()
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
                response.forEach { item in
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
    
    func loadDataIfNeeded() {
        if !dataLoaded {
            fecthCharacters()
            dataLoaded = true
        }
    }
}

// MARK: - Extensions
extension CharactersViewModel {
    static func make() -> CharactersViewModel {
        CharactersViewModel(charactersUseCase: Injector.resolve(CharacterUseCase.self))
    }
}
