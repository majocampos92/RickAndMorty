//
//  ServiceAssembly.swift
//  RickAndMorty
//
//  Created by Maria Campos on 4/2/25.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import Moya

public struct ServiceAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(MoyaProvider<RickAndMortyApi>.self) { _ in
            MoyaProvider<RickAndMortyApi>()
        }
        
        // MARK: Repositories
        container.register(CharacterRepository.self) { resolver in
            CharacterRepositoryImpl(apiService: resolver.resolve(MoyaProvider<RickAndMortyApi>.self)!)
        }
        container.register(LocationRepository.self) { resolver in
            LocationRepositoryImpl(apiService: resolver.resolve(MoyaProvider<RickAndMortyApi>.self)!)
        }
        
        // MARK: Use cases
        container.register(CharactersUseCase.self) { resolver in
            CharactersUseCaseImpl(repository: resolver.resolve(CharacterRepository.self)!)
        }
        
        container.register(LocationUseCase.self) { resolver in
            LocationUseCaseImpl(repository: resolver.resolve(LocationRepository.self)!)
        }
    }
}
