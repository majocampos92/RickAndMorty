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
    @Published var isLoading = false
    @Published var hasMorePages = true
    @Published var isSortedAZ = false
    
    var currentPage = 1
    var countCharacters = 0

    // MARK: Use cases
    private let charactersUseCase: CharacterUseCase
    
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization
    init(charactersUseCase: CharacterUseCase) {
        self.charactersUseCase = charactersUseCase
    }
    
    // MARK: Fetch all Characters
    func fetchCharacters(page: Int) {
        guard !isLoading, hasMorePages else { return }
        isLoading = true
        charactersUseCase.getAllCharacters(page: page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let failure):
                    self.error = failure
                    print("❌ Error in get all characters: \(failure)")
                case .finished:
                    self.isLoading = false
                    print("✅ Finish get all characters")
                }
            }, receiveValue: { response in
                self.countCharacters = response.info?.count ?? 0
                response.results?.forEach { item in
                    self.characters.append(
                        CharacterDTO(
                            id: item.id ?? 0,
                            name: item.name ?? "Unknown",
                            species: item.species ?? "Unknown",
                            image: item.image ?? "Unknown"
                        )
                    )
                }
                self.currentPage += 1
                self.hasMorePages = !self.characters.isEmpty
            })
            .store(in: &cancellables)
    }
    
    // MARK: Function to sort characters from A-Z
    func sortCharactersAZ() {
        characters.sort { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
    }

    func toggleSorting() {
        isSortedAZ.toggle()
        if isSortedAZ {
            sortCharactersAZ()
        } else {
            characters.sort { $0.id < $1.id }
        }
    }
    
    func loadDataIfNeeded() {
        if !dataLoaded {
            fetchCharacters(page: 1)
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
