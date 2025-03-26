//
//  CharacterRepository.swift
//  RickAndMorty
//
//  Created by Maria Campos on 21/2/25.
//

import Combine

protocol CharacterRepository {
    func getAllCharacters(page: Int) -> AnyPublisher<[Character], Error>
}
