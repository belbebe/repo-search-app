//
//  ContentView.swift
//  RepoSearch
//
//  Created by Belcsik Bence on 2025. 12. 10..
//

import RepoSearchNetworking
import SwiftUI
import Swinject

struct ContentView: View {
    @EnvironmentObject private var navigationHandler: DefaultNavigationHandler
    @EnvironmentObject private var diContainer: DIContainer
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack(path: $navigationHandler.path) {
            VStack {
                TextField("Type here info about the repository...", text: $viewModel.searchText)
                    .padding(8)
                    .modifier(BorderWithCornerRadiusModifier.default())
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
                RepoListView(viewModel: diContainer.swinjectContainer.resolve(
                    (any RepoListViewModelInterface).self,
                    arguments: viewModel.searchText, viewModel.repositories, navigationHandler as (any NavigationHandlerInterface)
                )! as! RepoListViewModel)
            }
            .onAppear {
                viewModel.navigationHandler = navigationHandler
            }
        }
    }
}
