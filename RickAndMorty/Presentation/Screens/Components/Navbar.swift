//
//  Navbar.swift
//  RickAndMorty
//
//  Created by Maria Campos on 5/3/25.
//

import SwiftUI
import Foundation

enum NavbarType {
    case home
    case list
}

struct NavbarSelector: View {
    var type: NavbarType
    var size: CGSize
    var title: String?
    let navigation: () -> Void
    
    var body: some View {
        switch type {
        case .home:
            HomeNavbar(size: size, navigation: navigation)
        case .list:
            ListNavbar(size: size, title: title ?? "Unknwon", navigation: navigation)
        }
    }
}

struct HomeNavbar: View {
    var size: CGSize
    let navigation: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {}) {
                Image("splash_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: size.width * 0.25,
                        height: size.height * 0.15
                    )
            }
        }
        .padding()
        .frame(
            width: size.width,
            height: size.height * 0.05,
            alignment: .center
        )
        .background(.white)
    }
}

struct ListNavbar: View {
    var size: CGSize
    var title: String
    let navigation: () -> Void
    
    @State var isSearchVisible: Bool = false
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(spacing: 8.0) {
            HStack {
                Button(action: {
                    navigation()
                }) {
                    Image(systemName: "chevron.left")
                }
                
                Spacer()
                
                Button(action: {
                    isSearchVisible.toggle()
                }) {
                    
                    Image(systemName: "magnifyingglass")
                }
                   
                Button(action: {}) {
                    Image(systemName: "line.3.horizontal.decrease")
                }
            }
            
            if isSearchVisible {
                TextField("Search", text: $searchText)
                    .padding(10)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(35)
                    .transition(.move(edge: .trailing)) // TODO: improve the animation
                    .overlay(
                        HStack {
                            Spacer()
                            if !searchText.isEmpty {
                                Button(action: {
                                    searchText = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 8)
                                .font(.system(size: 14))
                            }
                        }
                    )
            }

        }
        .padding(.horizontal)
        .font(.system(size: 16))
        .foregroundColor(Color("deep_navy"))
        .background(.white)
    }
}

#Preview {
    HomeNavbar(size: CGSize(width: 402.0, height: 874.0), navigation: {})
    ListNavbar(size: CGSize(width: 402.0, height: 874.0), title: "Unknwon", navigation: {})
}
