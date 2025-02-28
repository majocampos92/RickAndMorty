//
//  LocationRepositoryImpl.swift
//  RickAndMorty
//
//  Created by Maria Campos on 28/2/25.
//

import Moya
import Combine
import CombineMoya
import Foundation

class LocationRepositoryImpl: LocationRepository {
    
    private let apiService: MoyaProvider<RickAndMortyApi>
    
    init(apiService: MoyaProvider<RickAndMortyApi>) {
        self.apiService = apiService
    }
    
    func getAllLocations() -> AnyPublisher<[Location], any Error> {
        return apiService.requestPublisher(.getAllLocations)
            .tryMap { response -> [Location] in
                let model = try JSONDecoder().decode(LocationsModel.self, from: response.data)
                let results = model.results ?? []
                
                return results.map { location in
                    Location(
                        id: location.id ?? 0,
                        name: location.name ?? "Unknown",
                        type: location.type ?? "Unknown",
                        dimension: location.dimension ?? "Unknown",
                        residents: location.residents ?? [],
                        url: location.url ?? "Unknown",
                        created: location.created ?? "Unknown"
                    )
                }
            }
            .eraseToAnyPublisher()
    }
}
