//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Maria Campos on 1/2/25.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = .make()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height * 0.15,
                alignment: .top
            )
            .background(Color("deep_navy"))
            .ignoresSafeArea()
            VStack {
                //MARK: Characters Section
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.characters, id: \.id) { character in
                            VStack(alignment: .leading, spacing: 8) {
                                KFImage(URL(string: character.image)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(
                                        width: geometry.size.width * 0.30,
                                        height: geometry.size.height * 0.15
                                    )
                                    .clipped()
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(character.name)
                                    
                                    Text(character.species)
                                }
                                .padding()
                            }
                            .frame(
                                width: geometry.size.width * 0.30,
                                height: geometry.size.height * 0.25,
                                alignment: .leading
                            )
                            .background(.white)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 3)
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .onAppear {
                        viewModel.fecthCharacters()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
