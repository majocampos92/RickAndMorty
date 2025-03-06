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
                NavbarSelector(type: .home, size: geometry.size)
                
                ScrollView(.vertical, showsIndicators: false){
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
                        }
                        
                        VStack {
                            ForEach(viewModel.episodes, id: \.id) { episode in
                                VStack(alignment: .leading) {
                                    Text("\(episode.name)")
                                    
                                    Text("\(episode.episode)")
                                    
                                    Text("\(episode.airDate)")
                                }
                                .padding()
                                .frame(
                                    width: geometry.size.width * 0.95,
                                    height: geometry.size.height * 0.10,
                                    alignment: .leading
                                )
                                .background(.white)
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 3)
                            }
                        }
                        
                        // MARK: Locations Section
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.locations, id: \.id) { location in
                                    VStack(alignment: .leading, spacing: 4) {
                                        Image("\(location.image.rawValue)")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(
                                                width: geometry.size.width * 0.45,
                                                height: geometry.size.height * 0.25
                                            )
                                            .clipped()
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            
                                            Text(location.name)
                                            
                                            Text(location.type)
                                        }
                                        .padding()
                                    }
                                    .frame(
                                        width: geometry.size.width * 0.45,
                                        height: geometry.size.height * 0.35,
                                        alignment: .leading
                                    )
                                    .background(.white)
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 3)
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fecthCharacters()
            viewModel.fetchLocations()
            viewModel.fetchEpisodes()
        }
    }
}

#Preview {
    HomeView()
}
