//
//  RepoDetailsViewModel.swift
//  RepoSearch
//
//  Created by Belcsik Bence on 2025. 12. 14..
//

import RepoSearchNetworking
import SwiftUI

@MainActor
protocol RepoDetailsViewModelInterface {
    var repository: Repository { get }
}

@MainActor
final class RepoDetailsViewModel: ObservableObject, RepoDetailsViewModelInterface {
    @Published var repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
}
