//
//  ContentView.swift
//  RepoSearch
//
//  Created by Belcsik Bence on 2025. 12. 10..
//

import RepoSearchNetworking
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            VStack {
                TextField("Type here info about the repository...", text: $viewModel.searchText)
                    .padding(8)
                    .modifier(
                        BorderWithCornerRadiusModifier(
                            backGroundColor: Constants.mainBackgroundColor,
                            borderColor: .gray,
                            cornerRadius: 4,
                            borderWidth: 1
                        )
                    )
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                
                Button(action: {
                    Task { await viewModel.searchButtonPressed() }
                }) {
                    HStack(spacing: 4) {
                        Text("Search")
                        
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .tint(.black)
                        }
                    }
                }
                .padding(8)
                .foregroundStyle(.black)
                .modifier(
                    BorderWithCornerRadiusModifier(
                        backGroundColor: .blue,
                        borderColor: .purple,
                        cornerRadius: 8,
                        borderWidth: 2
                    )
                )
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundStyle(.red)
                }
            }
            .addDefaultScreenPadding()
            .navigationTitle("Repo Search")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: [Repository].self) { (repos: [Repository]) in
                RepoListView(viewModel: RepoListViewModel(searchText: viewModel.searchText, repositories: repos))
            }
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
