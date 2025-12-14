//
//  RepoListViewModel.swift
//  RepoSearch
//
//  Created by Belcsik Bence on 2025. 12. 14..
//

import RepoSearchNetworking
import SwiftUI

@MainActor
final class RepoListViewModel: ObservableObject {
    // TODO: convert properties to let after implementing DI
    @Published var searchText: String
    @Published var repositories: [Repository]
    var navigationHandler: any NavigationHandlerInterface
    
    init(searchText: String = "", repositories: [Repository] = [], navigationHandler: any NavigationHandlerInterface) {
        self.searchText = searchText
        self.repositories = repositories
        self.navigationHandler = navigationHandler
    }
}

// MARK: - Event handling
extension RepoListViewModel {
    func repoListItemPressed(with repo: Repository) {
        navigationHandler.navigate(to: repo)
    }
}

