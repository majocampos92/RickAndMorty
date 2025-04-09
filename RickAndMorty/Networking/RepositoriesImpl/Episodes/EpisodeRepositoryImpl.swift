//
//  EpisodeRepositoryImpl.swift
//  RickAndMorty
//
//  Created by Maria Campos on 3/3/25.
//

import Foundation
import Combine
import Moya
import CombineMoya

class EpisodeRepositoryImpl: EpisodeRepository {
    private let apiService: MoyaProvider<RickAndMortyApi>
    
    init(apiService: MoyaProvider<RickAndMortyApi>) {
        self.apiService = apiService
    }
    
    func getAllEpisodes() -> AnyPublisher<[Episode], any Error> {
        return apiService.requestPublisher(.getAllEpisodes)
            .tryMap { response -> [Episode] in
                let model = try JSONDecoder().decode(EpisodesModel.self, from: response.data)
                let results = model.results ?? []
                
                return results.map { item in
                    Episode(
                        id: item.id ?? 0,
                        name: item.name ?? "Unknown",
                        airDate: item.airDate ?? "Unknown",
                        episode: item.episode ?? "Unknown",
                        characters: item.characters ?? ["Unknown"],
                        url: item.url ?? "Unknown",
                        created: item.created ?? "Unknown"
                    )
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getMultipleEpisodes(ids: String) -> AnyPublisher<[MultipleEpisodesModel], any Error> {
        apiService.requestPublisher(.getMultipleEpisodes(ids: ids))
            .tryMap { response -> [MultipleEpisodesModel] in
                let decoder = JSONDecoder()
                /// API returns a single episode eg.:  {...}
                if let single = try? decoder.decode(MultipleEpisodesModel.self, from: response.data) {
                    return [single]
                } else {
                    /// API returns a multiple episodes eg.: [{...}, {...}]
                    return try decoder.decode([MultipleEpisodesModel].self, from: response.data)
                }
            }
            .eraseToAnyPublisher()
    }
}
