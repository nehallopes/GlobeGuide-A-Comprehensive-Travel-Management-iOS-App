//
//  SearchBar.swift
//  GlobeGuide
//
//  Created by CDMStudent on 6/8/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void

    var body: some View {
        HStack {
            TextField("Search", text: $text, onCommit: onSearch)
                .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 0))
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .overlay(
                    HStack {
                        Spacer()
                        Button(action: {
                            onSearch()
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.trailing, 12)
                        }
                    }
                )
        }
        .padding([.horizontal, .bottom], 12)
    }
}
