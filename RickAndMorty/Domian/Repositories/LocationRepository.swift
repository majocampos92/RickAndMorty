//
//  LocationRepository.swift
//  RickAndMorty
//
//  Created by Maria Campos on 28/2/25.
//

import Foundation
import Combine

protocol LocationRepository {
    func getAllLocations() -> AnyPublisher<[Location], Error>
}
