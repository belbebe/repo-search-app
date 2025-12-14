//
//  RepoDetailsViewModel.swift
//  RepoSearch
//
//  Created by Belcsik Bence on 2025. 12. 14..
//

import RepoSearchNetworking
import SwiftUI

@MainActor
final class RepoDetailsViewModel: ObservableObject {
    @Published var repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
}
