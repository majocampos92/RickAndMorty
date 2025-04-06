//
//  CharacterRepository.swift
//  RickAndMorty
//
//  Created by Maria Campos on 21/2/25.
//

import Combine

protocol CharacterRepository {
    func getAllCharacters(page: Int) -> AnyPublisher<CharactersModel, Error>
    func getCharacterDetail(id: Int) -> AnyPublisher<CharacterDetailModel, Error>
}
