//
//  ContentViewModel.swift
//  RepoSearch
//
//  Created by Belcsik Bence on 2025. 12. 13..
//

import Foundation
import RepoSearchNetworking
import SwiftUI

@MainActor
final class ContentViewModel: ObservableObject {
    @Published var searchText: String
    @Published var isLoading: Bool
    @Published var repositories: [Repository]
    @Published var errorMessage: String?
    var navigationHandler: (any NavigationHandlerInterface)?
    
    private let client: SearchClientInterface
    
    init(
        client: SearchClientInterface = DefaultSearchClient()
    ) {
        self.searchText = ""
        self.isLoading = false
        self.repositories = []
        self.errorMessage = nil
        self.navigationHandler = nil
        self.client = client
    }
}

// MARK: - Event handling
extension ContentViewModel {
    func searchButtonPressed() async {
        guard !searchText.isEmpty, let navigationHandler else {
            repositories = []
            return
        }
        isLoading = true
        errorMessage = nil
        do {
            let request = SearchRepositoriesRequest(query: searchText)
            let response = try await client.searchRepositories(request)
            repositories = response.items
            navigationHandler.navigate(to: repositories)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
