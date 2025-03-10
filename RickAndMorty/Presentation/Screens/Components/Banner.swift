//
//  Banner.swift
//  RickAndMorty
//
//  Created by Maria Campos on 6/3/25.
//

import SwiftUI

struct Banner: View {
    let size: CGSize
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Welcome to The Infinite Chaos")
                        .fontWeight(.bold)
                        .font(.system(size: 24))
                        .foregroundColor(Color("endo"))
                    
                    Text("Get ready to dive into the wacky, wild, and totally unpredictable world of Rick and Morty! Follow the galaxy’s most brilliant scientist, Rick Sanchez, as he drags his awkward but lovable grandson, Morty, through interdimensional adventures, alien invasions, and mind-bending paradoxes.")
                        .fontWeight(.regular)
                        .font(.system(size: 14))
                        .lineLimit(3)
                        .foregroundColor(Color("deep_navy"))
                    
                    Spacer()
                }
                .padding()
            }
            .frame(
                width: size.width,
                height: size.height * 0.35,
                alignment: .top
            )
            
            Image("banner_bg")
                .resizable()
                .scaledToFit()
                .frame(
                    width: size.width,
                    height: size.height * 0.35,
                    alignment: .bottom
                )
        }
        .background(.white)
    }
}


#Preview {
    Banner(size: CGSize(width: 402.0, height: 874.0))
}
