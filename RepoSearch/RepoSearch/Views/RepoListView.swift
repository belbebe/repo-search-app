//
//  RepoListView.swift
//  RepoSearch
//
//  Created by Belcsik Bence on 2025. 12. 13..
//

import RepoSearchNetworking
import SwiftUI

struct RepoListView: View {
    @StateObject private var viewModel: RepoListViewModel
    
    init(viewModel: RepoListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(viewModel.repositories) { repository in
                    RepoListItem(repository: repository)
                }
            }
        }
        .contentMargins(16, for: .scrollContent)
        .navigationTitle("Repos for term: \(viewModel.searchText)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RepoListView(viewModel: RepoListViewModel())
}
