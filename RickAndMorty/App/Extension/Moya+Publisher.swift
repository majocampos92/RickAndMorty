//
//  Moya+Publisher.swift
//  RickAndMorty
//
//  Created by Maria Campos on 4/2/25.
//

import Foundation
import Moya
import CombineMoya
import Combine

extension MoyaProvider {
    // Returns an AnyPublisher with data encoded to a specified model
    func requestPublisher<T: Decodable>(_ target: Target) -> AnyPublisher<T, Error> {
        self
            .requestPublisher(target)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
