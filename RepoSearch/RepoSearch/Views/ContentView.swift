//
//  ContentView.swift
//  RepoSearch
//
//  Created by Belcsik Bence on 2025. 12. 10..
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    @State private var stringToSearch = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                TextField("Type here info about the repository...", text: $stringToSearch)
                    .padding(8)
                    .modifier(
                        BorderWithCornerRadius(
                            backGroundColor: Constants.mainBackgroundColor,
                            borderColor: .gray,
                            cornerRadius: 4,
                            borderWidth: 1
                        )
                    )
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                
                Button(action: {}) {
                    Text("Search")
                }
                .padding(8)
                .foregroundStyle(.black)
                .modifier(
                    BorderWithCornerRadius(
                        backGroundColor: .blue,
                        borderColor: .purple,
                        cornerRadius: 8,
                        borderWidth: 2
                    )
                )
            }
            .padding()
            .navigationTitle("Repo Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Constants
extension ContentView {
    enum Constants {
        static let mainBackgroundColor = Color("Main")
    }
}

#Preview {
    ContentView()
}
