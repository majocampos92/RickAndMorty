//
//  GetCharacterDetailUseCase.swift
//  RickAndMorty
//
//  Created by Maria Campos on 3/4/25.
//

import Moya
import CombineMoya
import Combine
import Foundation

protocol GetCharacterDetailUseCase {
    func getDetailCharacter(id: Int) -> AnyPublisher<CharacterDetailModel, Error>
}

struct GetCharacterDetailUseCaseImpl: GetCharacterDetailUseCase {
    private let repository: CharacterRepository

    init(repository: CharacterRepository) {
        self.repository = repository
    }
    
    func getDetailCharacter(id: Int) -> AnyPublisher<CharacterDetailModel, Error> {
        return repository.getCharacterDetail(id: id)
    }
}
