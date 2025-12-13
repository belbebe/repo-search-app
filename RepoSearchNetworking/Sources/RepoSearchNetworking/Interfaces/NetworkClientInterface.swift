//
//  NetworkClientInterface.swift
//  RepoSearchNetworking
//
//  Created by Belcsik Bence on 2025. 12. 13..
//

import Foundation

public protocol NetworkClientInterface {
    func send<T: Decodable>(_ request: URLRequest) async throws -> T
}
