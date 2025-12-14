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
    
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: .zero) {
            Text(key)
                .fontWeight(.bold)
            Spacer()
            Text(value)
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    KeyValue(key: "Key", value: "Value")
}
