//
//  Repository.swift
//  RepoSearchNetworking
//
//  Created by Belcsik Bence on 2025. 12. 13..
//

import Foundation

public struct Repository: Decodable, Identifiable, Hashable {
    public let id: Int
    public let name: String
    public let fullName: String
    public let description: String?
    public let htmlUrl: URL
    public let stargazersCount: Int
    public let forksCount: Int
    public let language: String?
    public let owner: RepositoryOwner
    public let createdAt: String
    public let updatedAt: String
    
    public var createdAtDate: Date? {
        return ISO8601DateFormatter().date(from: createdAt)
    }
    public var updatedAtDate: Date? {
        return ISO8601DateFormatter().date(from: updatedAt)
    }
    
    public init(
        id: Int,
        name: String,
        fullName: String,
        description: String?,
        htmlUrl: URL,
        stargazersCount: Int,
        forksCount: Int,
        language: String?,
        owner: RepositoryOwner,
        createdAt: String,
        updatedAt: String
    ) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.description = description
        self.htmlUrl = htmlUrl
        self.stargazersCount = stargazersCount
        self.forksCount = forksCount
        self.language = language
        self.owner = owner
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
