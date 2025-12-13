//
//  SearchRepositoriesRequest.swift
//  RepoSearchNetworking
//
//  Created by Belcsik Bence on 2025. 12. 13..
//

import Foundation

public struct SearchRepositoriesRequest {
    public let query: String
    public let sort: String?
    public let order: String?
    public let perPage: Int?
    public let page: Int?
    
    public init(
        query: String,
        sort: String? = nil,
        order: String? = nil,
        perPage: Int? = nil,
        page: Int? = nil
    ) {
        self.query = query
        self.sort = sort
        self.order = order
        self.perPage = perPage
        self.page = page
    }
}

// MARK: - Make URL request
public extension SearchRepositoriesRequest {
    func makeURLRequest() throws -> URLRequest {
        // MARK: - Components
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/search/repositories"
        
        var items: [URLQueryItem] = [
            URLQueryItem(name: "q", value: query)
        ]
        if let sort { items.append(URLQueryItem(name: "sort", value: sort)) }
        if let order { items.append(URLQueryItem(name: "order", value: order)) }
        if let perPage { items.append(URLQueryItem(name: "per_page", value: String(perPage))) }
        if let page { items.append(URLQueryItem(name: "page", value: String(page))) }
        
        components.queryItems = items
        
        // MARK: - URL
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        // MARK: - Request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/vnd.github+json",
                         forHTTPHeaderField: "Accept")
        request.setValue("2022-11-28",
                         forHTTPHeaderField: "X-GitHub-Api-Version")
        return request
    }
}
