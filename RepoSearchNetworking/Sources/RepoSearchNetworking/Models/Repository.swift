//
//  Repository.swift
//  RepoSearchNetworking
//
//  Created by Belcsik Bence on 2025. 12. 13..
//

import Foundation

public struct Repository: Decodable, Identifiable {
    public let id: Int
    public let name: String
    public let fullName: String
    public let description: String?
    public let htmlUrl: URL
    public let stargazersCount: Int
    public let language: String?
    public let owner: RepositoryOwner
}
