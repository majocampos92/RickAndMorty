//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Maria Campos on 27/3/25.
//

import SwiftUI

struct CharacterDetailView: View {
    @StateObject var viewModel: CharacterDetailViewModel = .make()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                viewModel.getCharacter(id: 1)
            }
    }
}

#Preview {
    CharacterDetailView()
}
