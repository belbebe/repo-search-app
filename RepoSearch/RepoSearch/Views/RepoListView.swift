//
//  RepoListView.swift
//  RepoSearch
//
//  Created by Belcsik Bence on 2025. 12. 13..
//

import RepoSearchNetworking
import SwiftUI

struct RepoListView: View {
    @EnvironmentObject private var diContainer: DIContainer
    @StateObject private var viewModel: RepoListViewModel
    
    init(viewModel: RepoListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(viewModel.repositories) { (repository: Repository) in
                    RepoListItem(repository: repository, onTap: viewModel.repoListItemPressed)
                }
            }
        }
        .contentMargins(16, for: .scrollContent)
        .navigationTitle("Repos for term: \(viewModel.searchText)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Repository.self) { (repository: Repository) in
            RepoDetailsView(viewModel: diContainer.swinjectContainer.resolve((any RepoDetailsViewModelInterface).self, argument: repository)! as! RepoDetailsViewModel)
        }
    }
}
