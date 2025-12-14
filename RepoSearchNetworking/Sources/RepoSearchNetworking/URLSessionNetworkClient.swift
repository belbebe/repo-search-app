//
//  URLSessionNetworkClient.swift
//  RepoSearchNetworking
//
//  Created by Belcsik Bence on 2025. 12. 13..
//

import Foundation

@available(iOS 15.0, macOS 12.0, *)
public struct URLSessionNetworkClient: NetworkClientInterface {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    public init(session: URLSession = .shared) {
        self.session = session
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder = decoder
    }
    
    public func send<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200..<300).contains(http.statusCode) else {
            throw NetworkError.httpStatus(http.statusCode, data)
        }
        return try decoder.decode(T.self, from: data)
    }
}
