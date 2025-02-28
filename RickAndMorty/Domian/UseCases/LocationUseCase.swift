//
//  LocationUseCase.swift
//  RickAndMorty
//
//  Created by Maria Campos on 28/2/25.
//

import Moya
import CombineMoya
import Combine
import Foundation

protocol LocationUseCase {
    func getAllLocations() -> AnyPublisher<[Location], Error>
}

struct LocationUseCaseImpl: LocationUseCase {
    private let repository: LocationRepository
    
    init(repository: LocationRepository) {
        self.repository = repository
    }
    
    func getAllLocations() -> AnyPublisher<[Location], any Error> {
        return repository.getAllLocations()
    }
}
