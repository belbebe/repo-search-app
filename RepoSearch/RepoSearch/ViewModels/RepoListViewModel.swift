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
    
    init(searchText: String = "", repositories: [Repository] = []) {
        self.searchText = searchText
        self.repositories = repositories
    }
}
