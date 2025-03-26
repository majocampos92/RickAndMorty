//
//  CharactersView.swift
//  RickAndMorty
//
//  Created by Maria Campos on 15/3/25.
//

import SwiftUI
import FlowStacks

struct CharactersView: View {
    @StateObject var viewModel: CharactersViewModel = .make()
    @Binding var routes: [Route<Screen>]
    @Environment(\.dismiss) var dismiss
    
    @State private var columns: Int = 3
    
    var gridLayout: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 16), count: columns)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                NavbarSelector(type: .list, size: geometry.size, title: "Characters") {
                    dismiss()
                }
                ZStack(alignment: .bottom) {
                    VStack {
                        Picker("Columns", selection: $columns) {
                            Text("2 per row").tag(2)
                            Text("3 per row").tag(3)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: gridLayout, spacing: 16) {
                                ForEach(viewModel.characters, id: \.id) { character in
                                    CharacterCard(character: character, size: geometry.size)
                                        .onAppear {
                                            if let lastCharacter = viewModel.characters.last, character.id == lastCharacter.id {
                                                viewModel.fetchCharacters(page: viewModel.currentPage)
                                            }
                                        }
                                }
                                
                                if viewModel.isLoading {
                                    ProgressView().frame(height: 50)
                                }
                            }
                            .padding(.horizontal, 12.0)
                        }
                    }
                    
                    // MARK: TAB BAR
                    TabBar(routes: $routes, size: geometry.size)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.loadDataIfNeeded()
        }
    }
}

#Preview {
    CharactersView(routes: .constant([.root(.characters)]))
}
