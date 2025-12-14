//
//  KeyValue.swift
//  RepoSearch
//
//  Created by Belcsik Bence on 2025. 12. 13..
//

import SwiftUI

struct KeyValue: View {
    let key: String
    let value: String
    let isValueLink: Bool
    
    init(key: String, value: String, isValueLink: Bool = false) {
        self.key = key
        self.value = value
        self.isValueLink = isValueLink
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: .zero) {
            Text(key)
                .fontWeight(.bold)
            Spacer()
            if isValueLink {
                Link(value, destination: URL(string: value)!)
                    .foregroundStyle(.blue)
                    .multilineTextAlignment(.trailing)
            } else {
                Text(value)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}

#Preview {
    KeyValue(key: "Key", value: "Value")
}
