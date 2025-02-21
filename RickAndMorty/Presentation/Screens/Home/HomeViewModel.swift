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
    @Published var error: Error?

    private let charactersUseCase: CharactersUseCase
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization
    init(charactersUseCase: CharactersUseCase) {
        self.charactersUseCase = charactersUseCase
    }
    
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
                            image: item.image
                        )
                    )
                }
            })
            .store(in: &cancellables)
    }
}

// MARK: - Extensions
extension HomeViewModel {
    static func make() -> HomeViewModel {
        HomeViewModel(charactersUseCase: Injector.resolve(CharactersUseCase.self))
    }
}
