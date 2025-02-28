//
//  RickAndMortyApi.swift
//  RickAndMorty
//
//  Created by Maria Campos on 4/2/25.
//

import Moya
import Foundation

enum RickAndMortyApi {
    case getAllCharacters
    case getAllLocations
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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllCharacters:
            return .get
        case .getAllLocations:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getAllCharacters:
            return .requestPlain
        case .getAllLocations:
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
