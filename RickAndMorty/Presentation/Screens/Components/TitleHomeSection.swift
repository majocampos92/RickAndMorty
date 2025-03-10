//
//  TitleHomeSection.swift
//  RickAndMorty
//
//  Created by Maria Campos on 6/3/25.
//

import SwiftUI

// TODO: add navigation
struct TitleHomeSection: View {
    let title: String
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text("\(title)")
                .fontWeight(.semibold)
                .font(.system(size: 28))
            
            Spacer()
            
            Button(action: {}) {
                HStack(alignment: .center, spacing: 2.0) {
                    Text("See All")
                        .fontWeight(.regular)
                        .font(.system(size: 12))
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 10))
                }
            }
        }
        .padding(.horizontal, 12.0)
        .foregroundColor(Color("deep_navy"))
    }
}

#Preview {
    TitleHomeSection(title: "Unknown")
}
