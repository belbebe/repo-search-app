//
//  Repository+Factory.swift
//  RepoSearchTests
//
//  Created by Belcsik Bence on 2025. 12. 26..
//

import Foundation
import RepoSearchNetworking

// MARK: - Factory
extension Repository {
    static let mock: Self = Repository(
        id: 0,
        name: "name",
        fullName: "full name",
        description: "description",
        htmlUrl: URL(string: "https://github.com")!,
        stargazersCount: 0,
        forksCount: 0,
        language: "language",
        owner: RepositoryOwner(
            id: 0,
            login: "login",
            url: "url",
            htmlUrl: "html url",
            avatarUrl: nil
        ),
        createdAt: "created",
        updatedAt: "updated"
    )
}
