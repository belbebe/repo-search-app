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
    
    init(repository: Repository) {
        self.repository = repository
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
                    KeyValue(key: "Updated at:", value: "\(updatedAtDate.formatted(date: .abbreviated, time: .standard))")
                }
            }
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.blue)
                .scaleEffect(1.5)
                .padding(.horizontal, 4)
        }
        .padding(8)
        .modifier(
            BorderWithCornerRadiusModifier(
                backGroundColor: Color("Main"),
                borderColor: .gray,
                cornerRadius: 2,
                borderWidth: 2
            )
        )
    }
}
