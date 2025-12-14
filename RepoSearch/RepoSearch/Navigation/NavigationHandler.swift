//
//  NavigationHandler.swift
//  RepoSearch
//
//  Created by Belcsik Bence on 2025. 12. 14..
//

import SwiftUI

protocol NavigationHandlerInterface: ObservableObject {
    var path: NavigationPath { get }
    
    func navigate(to screen: any Hashable)
    func pop()
    func reset()
}

final class DefaultNavigationHandler: NavigationHandlerInterface {
    @Published var path = NavigationPath()
    
    func navigate(to screen: any Hashable) {
        path.append(screen)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func reset() {
        path = NavigationPath()
    }
}
