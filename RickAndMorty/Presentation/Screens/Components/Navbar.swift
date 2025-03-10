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
    
    var body: some View {
        switch type {
        case .home:
            HomeNavbar(size: size)
        case .list:
            ListNavbar(size: size, title: title ?? "Unknwon")
        }
    }
}

struct HomeNavbar: View {
    var size: CGSize
    
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
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("deep_navy"))
                }
                
                Spacer()
                
                Text("\(title)")
                    .foregroundColor(Color("deep_navy"))
                
                Spacer()
            }
        }
        .padding()
        .frame(
            width: size.width,
            height: size.height * 0.06
        )
        .background(.white)
    }
}

#Preview {
    HomeNavbar(size: CGSize(width: 402.0, height: 874.0))
    ListNavbar(size: CGSize(width: 402.0, height: 874.0), title: "Unknwon")
}
