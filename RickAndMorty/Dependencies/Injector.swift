//
//  Injector.swift
//  RickAndMorty
//
//  Created by Maria Campos on 4/2/25.
//

import Foundation
import Swinject

// MARK: - Dependency injection
enum Injector {
    static let shared: Assembler = {
        let container = Container()
        let assembler = Assembler([
            ServiceAssembly(),
        ], container: container)
        return assembler
    }()

    static func resolve<Service>(_ serviceType: Service.Type) -> Service {
        guard let service = shared.resolver.resolve(serviceType) else {
            fatalError("❌ Could not be resolved \(serviceType)")
        }
        return service
    }
}
