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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllCharacters:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getAllCharacters:
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
