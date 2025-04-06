//
//  CharacterRepositoryImpl.swift
//  RickAndMorty
//
//  Created by Maria Campos on 21/2/25.
//

import Moya
import Combine
import CombineMoya
import Foundation

final class CharacterRepositoryImpl: CharacterRepository {
    private let apiService: MoyaProvider<RickAndMortyApi>
    
    init(apiService: MoyaProvider<RickAndMortyApi>) {
        self.apiService = apiService
    }
    
    func getAllCharacters(page: Int) -> AnyPublisher<CharactersModel, Error> {
        return apiService.requestPublisher(.getAllCharacters(page: page))
            .tryMap { response -> CharactersModel in
                return try JSONDecoder().decode(CharactersModel.self, from: response.data)
            }
            .eraseToAnyPublisher()
    }
    
    func getCharacterDetail(id: Int) -> AnyPublisher<DetailCharacterModel, Error> {
        return apiService.requestPublisher(.getCharacter(id: id))
            .tryMap { reponse -> DetailCharacterModel in
                return try JSONDecoder().decode(DetailCharacterModel.self, from: reponse.data)
                
            }
            .eraseToAnyPublisher()
    }
}
