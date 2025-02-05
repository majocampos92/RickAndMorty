//
//  RickAndMortyApi.swift
//  RickAndMorty
//
//  Created by Maria Campos on 4/2/25.
//
import Moya
import Foundation

enum RickAndMortyApi {}

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
        "/"
    }
    
    var method: Moya.Method {
        return .get
    }

    var task: Task {
        return .requestPlain
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
