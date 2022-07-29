//
//  TextField+SearchBarStyle.swift
//  Acronyms
//
//  Created by Lucas Coelho on 28/07/22.
//

import SwiftUI

extension TextField {
    func searchBarStyle() -> some View {
        modifier(SearchBarStyle())
    }
}

struct SearchBarStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 8))
    }
}
