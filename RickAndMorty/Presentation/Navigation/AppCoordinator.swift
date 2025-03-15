//
//  AppCoordinator.swift
//  RickAndMorty
//
//  Created by Maria Campos on 15/3/25.
//

import SwiftUI
import Foundation
import FlowStacks

struct AppCoordinator: View {
    @State var routes: [Route<Screen>] = []
    
    var body: some View {
        FlowStack($routes, withNavigation: true) {
            HomeView(routes: $routes)
                .flowDestination(for: Screen.self) { screen in
                    switch screen {
                    case .characters:
                        CharactersView()
                    }
                }
        }
    }
}
