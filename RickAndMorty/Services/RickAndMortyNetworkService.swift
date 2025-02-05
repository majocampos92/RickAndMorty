//
//  RickAndMortyNetworkService.swift
//  RickAndMorty
//
//  Created by Maria Campos on 4/2/25.
//
import Moya
import CombineMoya
import Combine

// MARK: - Protocols
protocol RickAndMortyServiceType {}

// MARK: - Networking Services
struct RickAndMortyNetworkService: RickAndMortyServiceType {
    
    private let api =  MoyaProvider<RickAndMortyApi>()
    
}
