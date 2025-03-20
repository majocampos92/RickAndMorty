//
//  CharacterCard.swift
//  RickAndMorty
//
//  Created by Maria Campos on 18/3/25.
//

import SwiftUI
import Foundation
import Kingfisher

struct CharacterCard: View {
    let character: CharacterDTO
    let size: CGSize
    
    var body: some View {
        Button(action: {}) {
            VStack(alignment: .center, spacing: 0.0) {
                KFImage(URL(string: character.image)!)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: size.width * 0.25,
                        height: size.height * 0.15
                    )
                    .clipShape(Circle())
                
                Text(character.name)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(
                        width: size.width * 0.25,
                        height: size.height * 0.05,
                        alignment: .top
                    )
                    .font(.system(size: 16))
                
            }
        }
    }
}
