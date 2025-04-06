//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Maria Campos on 27/3/25.
//

import SwiftUI

struct CharacterDetailView: View {
    @StateObject var viewModel: CharacterDetailViewModel = .make()
    let id: Int
    var body: some View {
        Text("\(viewModel.detailCharacter.name)")
            .onAppear {
                viewModel.getCharacter(id: id)
            }
    }
}

#Preview {
    CharacterDetailView(id: 0)
}
