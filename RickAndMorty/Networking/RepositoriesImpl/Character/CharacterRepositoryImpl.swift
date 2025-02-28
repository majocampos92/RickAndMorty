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
    
    func getAllCharacters() -> AnyPublisher<[Character], Error> {
        return apiService.requestPublisher(.getAllCharacters)
            .tryMap { response -> [Character] in
                let model = try JSONDecoder().decode(CharactersModel.self, from: response.data)
                let results = model.results ?? []

                return results.map { character in
                    Character(
                        id: character.id ?? 0,
                        name: character.name ?? "Unknown",
                        status: character.status ?? "Unknown",
                        species: character.species ?? "Unknown",
                        type: character.type ?? "",
                        gender: character.gender ?? "Unknown",
                        origin: character.origin ?? CharacterLocation(name: "Unknown", url: ""),
                        location: character.location ?? CharacterLocation(name: "Unknown", url: ""),
                        image: character.image ?? "",
                        episode: character.episode ?? [],
                        url: character.url ?? "",
                        created: character.created ?? ""
                    )
                }
            }
            .eraseToAnyPublisher()
    }
}
