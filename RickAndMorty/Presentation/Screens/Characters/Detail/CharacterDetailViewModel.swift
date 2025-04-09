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
    @Published var error: Error?
    
    private let getCharacterDetailUseCase: GetCharacterDetailUseCase
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init(getCharacterDetailUseCase: GetCharacterDetailUseCase) {
        self.getCharacterDetailUseCase = getCharacterDetailUseCase
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
                }
            }, receiveValue: { response in
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
}

// MARK: - Extensions
extension CharacterDetailViewModel {
    static func make() -> CharacterDetailViewModel {
        CharacterDetailViewModel(getCharacterDetailUseCase: Injector.resolve(GetCharacterDetailUseCase.self))
    }
}
