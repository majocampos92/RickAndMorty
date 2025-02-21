//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Maria Campos on 1/2/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = .make()
    
    var body: some View {
        VStack {            
            List(viewModel.characters, id: \.id) { character in
                VStack(alignment: .leading) {
                    Text(character.name)
                        .font(.headline)
                    Text(character.species)
                        .font(.subheadline)
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fecthCharacters()
        }
    }
}

#Preview {
    HomeView()
}
