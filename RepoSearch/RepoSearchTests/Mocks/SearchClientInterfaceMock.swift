//
//  SearchClientInterfaceMock.swift
//  RepoSearchTests
//
//  Created by Belcsik Bence on 2025. 12. 22..
//

import Foundation
import RepoSearchNetworking

class SearchClientInterfaceMock: SearchClientInterface {
    var requests: [SearchRepositoriesRequest] = []
    var mockError: Error?
    var mockResponse = SearchRepositoriesResponse(
        totalCount: 0,
        incompleteResults: false,
        items: []
    )
    
    func searchRepositories(_ request: SearchRepositoriesRequest) async throws -> SearchRepositoriesResponse {
        requests.append(request)
        if let error = mockError {
            throw error
        }
        return mockResponse
    }
}
