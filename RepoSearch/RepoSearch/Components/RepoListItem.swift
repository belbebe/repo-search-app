//
//  RepoListItem.swift
//  RepoSearch
//
//  Created by Belcsik Bence on 2025. 12. 13..
//

import RepoSearchNetworking
import SwiftUI

struct RepoListItem: View {
    private let repository: Repository
    private let onTap: (_ repo: Repository) -> Void
    
    init(repository: Repository, onTap: @escaping (_ repo: Repository) -> Void) {
        self.repository = repository
        self.onTap = onTap
    }
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(repository.name)
                    .font(.headline)
                    .fontWeight(.heavy)
                KeyValue(key: "Full name:", value: repository.fullName)
                if let description = repository.description {
                    KeyValue(key: "Description:", value: description)
                }
                KeyValue(key: "Number of stars:", value: "\(repository.stargazersCount)")
                if let updatedAtDate = repository.updatedAtDate {
                    KeyValue(key: "Last updated at:", value: "\(updatedAtDate.formatted(date: .abbreviated, time: .standard))")
                }
            }
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.blue)
                .scaleEffect(1.5)
                .padding(.horizontal, 4)
        }
        .onTapGesture {
            onTap(repository)
        }
        .padding(8)
        .modifier(BorderWithCornerRadiusModifier.defaultThick())
    }
}
