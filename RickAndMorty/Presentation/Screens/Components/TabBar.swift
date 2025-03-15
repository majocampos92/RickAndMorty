//
//  TabBar.swift
//  RickAndMorty
//
//  Created by Maria Campos on 7/3/25.
//

import SwiftUI
import FlowStacks

struct TabBar: View {
    @Binding var routes: [Route<Screen>]
    
    let size: CGSize
    
    var body: some View {
        HStack(spacing: 50) {
            Button(action: {}) {
                VStack {
                    Image(systemName: "house")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                    Text("Home")
                        .foregroundColor(.white)
                        .font(.system(size: 8))
                }
            }
            
            Button(action: {
                routes.append(.push(.characters))
            }) {
                VStack {
                    Image("person_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                    Text("Characters")
                        .foregroundColor(.white)
                        .font(.system(size: 8))
                }
            }
            
            Button(action: {}) {
                VStack {
                Image(systemName: "map")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    
                    Text("Locations")
                        .foregroundColor(.white)
                        .font(.system(size: 8))
                }
            }
            
            Button(action: {}) {
                VStack {
                    Image(systemName: "film")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                    Text("Episodes")
                        .foregroundColor(.white)
                        .font(.system(size: 8))
                }
            }
        }
        .frame(width: size.width * 0.90, height: 55)
        .background(Color("deep_navy"))
        .cornerRadius(35)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
        .padding(8)
    }
}

#Preview {
    TabBar(routes: .constant([.root(.characters)]), size: CGSize(width: 402.0, height: 874.0))
}
