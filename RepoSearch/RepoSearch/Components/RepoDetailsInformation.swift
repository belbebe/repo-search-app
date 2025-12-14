//
//  RepoDetailsInformation.swift
//  RepoSearch
//
//  Created by Belcsik Bence on 2025. 12. 14..
//

import RepoSearchNetworking
import SwiftUI

struct RepoDetailsInformation: View {
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text(repository.name)
                .font(.headline)
            KeyValue(key: "Full name:", value: repository.fullName)
            if let description = repository.description {
                KeyValue(key: "Description:", value: description)
            }
            KeyValue(key: "GitHub link:", value: "\(repository.htmlUrl)", isValueLink: true)
            KeyValue(key: "Number of stars:", value: "\(repository.stargazersCount)")
            KeyValue(key: "Number of forks:", value: "\(repository.forksCount)")
            if let createdAtDate = repository.createdAtDate {
                KeyValue(key: "Created at:", value: "\(createdAtDate.formatted(date: .abbreviated, time: .standard))")
            }
            if let updatedAtDate = repository.updatedAtDate {
                KeyValue(key: "Last updated at:", value: "\(updatedAtDate.formatted(date: .abbreviated, time: .standard))")
            }
        }
    }
}
