//
//  CharactersView.swift
//  RickAndMorty
//
//  Created by Maria Campos on 15/3/25.
//

import SwiftUI
import FlowStacks

struct CharactersView: View {
    @Binding var routes: [Route<Screen>]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Hello world")
        }
    }
}

#Preview {
    CharactersView(routes: .constant([.root(.characters)]))
}
