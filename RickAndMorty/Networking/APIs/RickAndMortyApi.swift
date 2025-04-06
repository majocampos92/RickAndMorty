//
//  RickAndMortyApi.swift
//  RickAndMorty
//
//  Created by Maria Campos on 4/2/25.
//

import Moya
import Foundation

enum RickAndMortyApi {
    case getAllCharacters(page: Int)
    case getAllLocations
    case getAllEpisodes
    case getCharacter(id: Int)
}

// MARK: Extensions
extension RickAndMortyApi: TargetType {
    // MARK: - Proporties
    var baseURL: URL {
        guard let url = URL(string: Constants.baseUrl) else {
            fatalError(Constants.errorBaseUrl)
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getAllCharacters:
            return Endpoints.getAllCharacters
        case .getAllLocations:
            return Endpoints.getLocations
        case .getAllEpisodes:
            return Endpoints.getAllEpisodes
        case .getCharacter(id: let id):
            return "\(Endpoints.getCharacter)\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllCharacters:
            return .get
        case .getAllLocations:
            return .get
        case .getAllEpisodes:
            return .get
        case .getCharacter:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getAllCharacters(let page):
            return .requestParameters(
                parameters: [
                    "page": page
                ],
                encoding: URLEncoding.default
            )
        case .getAllLocations:
            return .requestPlain
        case .getAllEpisodes:
            return .requestPlain
        case .getCharacter:
            return .requestPlain
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
