//
//  RepositoryOwner.swift
//  RepoSearchNetworking
//
//  Created by Belcsik Bence on 2025. 12. 13..
//

import Foundation

public struct RepositoryOwner: Decodable, Identifiable, Hashable {
    public let id: Int
    public let login: String
    public let url: String
    public let htmlUrl: String
    public let avatarUrl: URL?
}
