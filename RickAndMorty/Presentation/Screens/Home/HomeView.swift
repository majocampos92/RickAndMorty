//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Maria Campos on 1/2/25.
//

import SwiftUI
import Kingfisher
import FlowStacks

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = .make()
    @Binding var routes: [Route<Screen>]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: .zero) {
                    
                    NavbarSelector(type: .home, size: geometry.size, navigation: {})
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        Banner(size: geometry.size)
                        
                        VStack(alignment: .leading, spacing: 8.0) {
                            
                            //MARK: Characters Section
                            VStack(alignment: .leading, spacing: 8.0) {
                                
                                TitleHomeSection(title: "Characters") {
                                    routes.append(.push(.characters))
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .top, spacing: 16.0) {
                                        ForEach(viewModel.characters, id: \.id) { character in
                                            CharacterCard(character: character, size: geometry.size)
                                        }
                                    }
                                    .padding(.horizontal, 12.0)
                                }
                                .foregroundColor(Color("deep_navy"))
                            }
                            
                            // MARK: Locations Section
                            VStack(alignment: .leading, spacing: 8.0) {
                                
                                TitleHomeSection(title: "Locations", navigation: {})
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .top, spacing: 16.0) {
                                        ForEach(viewModel.locations, id: \.id) { location in
                                            Button(action: {}) {
                                                VStack(alignment: .leading, spacing: 4.0) {
                                                    Image("\(location.image.rawValue)")
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(
                                                            width: geometry.size.width * 0.50,
                                                            height: geometry.size.height * 0.20
                                                        )
                                                        .clipped()
                                                    
                                                    VStack(alignment: .leading, spacing: 4) {
                                                        
                                                        Text(location.name)
                                                        
                                                        Text(location.type)
                                                    }
                                                    .font(.system(size: 16))
                                                    .padding()
                                                }
                                                .frame(
                                                    width: geometry.size.width * 0.40,
                                                    height: geometry.size.height * 0.30,
                                                    alignment: .leading
                                                )
                                                .background(.white)
                                                .cornerRadius(15)
                                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 3)
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 12.0)
                                    .padding(.bottom, 8.0)
                                }
                                .foregroundColor(Color("deep_navy"))
                            }
                            
                            // MARK: Episodes Section
                            VStack(alignment: .center, spacing: 8.0) {
                                
                                TitleHomeSection(title: "Episodes", navigation: {})
                                
                                VStack(alignment: .leading, spacing: 16.0) {
                                    ForEach(viewModel.episodes, id: \.id) { episode in
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text("\(episode.name)")
                                                
                                                Text("\(episode.episode)")
                                                
                                                Text("\(episode.airDate)")
                                            }
                                            .font(.system(size: 16))
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
                                }
                                .foregroundColor(Color("deep_navy"))
                            }
                            .padding(.bottom, 84)
                        }
                    }
                }
                
                // MARK: TAB BAR FLOTANTE
                TabBar(routes: $routes, size: geometry.size)
            }
        }
        .background(.white)
        .onAppear {
            viewModel.loadDataIfNeeded()
        }
    }
}

#Preview {
    HomeView(routes: .constant([.root(.characters)]))
}
