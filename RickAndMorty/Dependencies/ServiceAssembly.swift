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
        container.autoregister(RickAndMortyServiceType.self, initializer: RickAndMortyNetworkService.init)
    }
}
