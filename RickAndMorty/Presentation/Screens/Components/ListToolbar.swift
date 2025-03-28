//
//  ListToolbar.swift
//  RickAndMorty
//
//  Created by Maria Campos on 27/3/25.
//

import SwiftUI

struct ListToolbar: View {
    @Binding var columns: Int
    
    var sort: () -> Void
    let count: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            HStack {
                HStack(spacing: 0.0) {
                    Text("\(count) ")
                        .bold()
                    Text("Total results")
                }
                
                Spacer()
                
                HStack(spacing: 4.0) {
                    Image(systemName: "arrow.up.arrow.down")
                        .onTapGesture {
                            sort()
                        }
                    
                    Image(systemName: columns == 2 ? "square.grid.2x2.fill" : "square.grid.2x2")
                        .onTapGesture {
                            columns = 2
                        }
                    
                    Image(systemName: columns == 3 ? "square.grid.3x3.fill" : "square.grid.3x3" )
                        .onTapGesture {
                            columns = 3
                        }
                }
                .foregroundColor(Color("deep_navy"))
                .font(.system(size: 14))
            }
        }
        .padding(.horizontal)
    }
}
