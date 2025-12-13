//
//  SearchClientInterface.swift
//  RepoSearchNetworking
//
//  Created by Belcsik Bence on 2025. 12. 13..
//

import Foundation

public protocol SearchClientInterface {
    func searchRepositories(_ request: SearchRepositoriesRequest) async throws -> SearchRepositoriesResponse
}
