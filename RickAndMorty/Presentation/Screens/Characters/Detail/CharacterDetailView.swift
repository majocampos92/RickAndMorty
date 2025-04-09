//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Maria Campos on 27/3/25.
//

import SwiftUI
import Kingfisher

struct CharacterDetailView: View {
    @StateObject var viewModel: CharacterDetailViewModel = .make()
    let id: Int
    var body: some View {
        GeometryReader { reader in
            ScrollView {
                VStack(alignment: .leading, spacing: 12.0) {
                    KFImage(URL(string: viewModel.characterDetail.image)!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: reader.size.width, height: reader.size.height * 0.35)
                        .clipped()
                    
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text("\(viewModel.characterDetail.name)")
                        Text("\(viewModel.characterDetail.status)")
                        Text("\(viewModel.characterDetail.specie)")
                        Text("\(viewModel.characterDetail.gender)")
                        Text("\(viewModel.characterDetail.origin)")
                        Text("\(viewModel.characterDetail.location)")
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.getCharacter(id: id)
        }
    }
}

#Preview {
    CharacterDetailView(id: 0)
}
