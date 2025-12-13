//
//  NetworkError.swift
//  RepoSearchNetworking
//
//  Created by Belcsik Bence on 2025. 12. 13..
//

import Foundation

public enum NetworkError: Error {
    case invalidResponse
    case httpStatus(Int, Data)
}
