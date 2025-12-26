//
//  Container.swift
//  RepoSearch
//
//  Created by Belcsik Bence on 2025. 12. 14..
//

import RepoSearchNetworking
import Swinject
import SwiftUI

@MainActor
final class DIContainer: ObservableObject {
    static let shared = DIContainer()
    let swinjectContainer = Container()
    
    private init() {
        registerViewModels()
        registerServices()
    }
}

// MARK: - Registration
private extension DIContainer {
    func registerViewModels() {
        swinjectContainer.register((any RepoDetailsViewModelInterface).self) { (_, repository: Repository) in
            RepoDetailsViewModel(repository: repository)
        }
        .inObjectScope(.transient)
        
        swinjectContainer.register((any RepoListViewModelInterface).self) {
            (resolver: Resolver, searchText: String, repos: [Repository], navigationHandler: NavigationHandlerInterface) in
            RepoListViewModel(
                searchText: searchText,
                repositories: repos,
                navigationHandler: navigationHandler
            )
        }
        .inObjectScope(.transient)
    }
    
    func registerServices() {
        swinjectContainer.register((any SearchClientInterface).self) { _ in
            DefaultSearchClient()
        }
        .inObjectScope(.container)
    }
}
