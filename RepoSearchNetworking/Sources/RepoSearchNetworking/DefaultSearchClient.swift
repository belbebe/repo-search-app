//
//  DefaultSearchClient.swift
//  RepoSearchNetworking
//
//  Created by Belcsik Bence on 2025. 12. 13..
//

import Foundation

@available(macOS 12.0, *)
public struct DefaultSearchClient: SearchClientInterface {
    private let network: NetworkClientInterface
    
    public init(network: NetworkClientInterface = URLSessionNetworkClient()) {
        self.network = network
    }
    
    public func searchRepositories(_ request: SearchRepositoriesRequest) async throws -> SearchRepositoriesResponse {
        let urlRequest = try request.makeURLRequest()
        return try await network.send(urlRequest)
    }
}
