//
//  BorderWithCornerRadiusModifier.swift
//  RepoSearch
//
//  Created by Belcsik Bence on 2025. 12. 10..
//

import SwiftUI

struct BorderWithCornerRadiusModifier: ViewModifier {
    let backGroundColor: Color
    let borderColor: Color
    let cornerRadius: CGFloat
    let borderWidth: CGFloat
    
    init(backGroundColor: Color, borderColor: Color, cornerRadius: CGFloat, borderWidth: CGFloat) {
        self.backGroundColor = backGroundColor
        self.borderColor = borderColor
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
    }
    
    func body(content: Content) -> some View {
        content
            .background(backGroundColor)
            .cornerRadius(cornerRadius)
            .padding(borderWidth)
            .background(borderColor)
            .cornerRadius(cornerRadius + borderWidth)
    }
}
