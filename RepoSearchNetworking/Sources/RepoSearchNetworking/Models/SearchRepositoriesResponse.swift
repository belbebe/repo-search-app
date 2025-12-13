//
//  SearchRepositoriesResponse.swift
//  RepoSearchNetworking
//
//  Created by Belcsik Bence on 2025. 12. 13..
//

import Foundation

public struct SearchRepositoriesResponse: Decodable {
    public let totalCount: Int
    public let incompleteResults: Bool
    public let items: [Repository]
}
