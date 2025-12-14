//
//  DefaultScreenPaddingModifier.swift
//  RepoSearch
//
//  Created by Belcsik Bence on 2025. 12. 14..
//

import SwiftUI

struct DefaultScreenPaddingModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 16)
    }
}

extension View {
    public func addDefaultScreenPadding() -> some View {
        self.modifier(DefaultScreenPaddingModifier())
    }
}
