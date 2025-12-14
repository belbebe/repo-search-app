//
//  OwnerDetails.swift
//  RepoSearch
//
//  Created by Belcsik Bence on 2025. 12. 14..
//

import RepoSearchNetworking
import SwiftUI

struct OwnerDetails: View {
    private let owner: RepositoryOwner
    
    init(owner: RepositoryOwner) {
        self.owner = owner
    }
    
    var body: some View {
        VStack(spacing: 16) {
            if let avatarUrl = owner.avatarUrl {
                AsyncImage(url: avatarUrl) { image in
                    image
                        .image?.resizable()
                        .scaledToFill()
                }
                .frame(width: 250, height: 250)
                .clipped()
                .padding(.bottom, 16)
            }
            VStack(alignment: .leading, spacing: 12) {
                Text(owner.login)
                    .font(.headline)
                KeyValue(key: "GitHub profile:", value: owner.htmlUrl, isValueLink: true)
            }
        }
        .padding(8)
        .modifier(BorderWithCornerRadiusModifier.defaultThick())
    }
}
