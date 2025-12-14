//
//  RepoDetailsView.swift
//  RepoSearch
//
//  Created by Belcsik Bence on 2025. 12. 14..
//

import RepoSearchNetworking
import SwiftUI

struct RepoDetailsView: View {
    @StateObject private var viewModel: RepoDetailsViewModel
    
    init(viewModel: RepoDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                OwnerDetails(owner: viewModel.repository.owner)
                RepoDetailsInformation(repository: viewModel.repository)
            }
        }
        .contentMargins(16, for: .scrollContent)
        .navigationTitle("Repo details for: \(viewModel.repository.name)")
        .navigationBarTitleDisplayMode(.inline)
    }
}
