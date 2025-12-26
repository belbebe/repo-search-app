//
//  NavigationHandlerInterfaceMock.swift
//  RepoSearchTests
//
//  Created by Belcsik Bence on 2025. 12. 22..
//

import Foundation
import RepoSearch
import SwiftUI

class NavigationHandlerInterfaceMock: NavigationHandlerInterface {
    var path: NavigationPath = NavigationPath()
    var numberOfNavigationInvocation = 0
    var navigationParameter: (any Hashable)?
    var numberOfPopInvocation = 0
    var numberOfResetInvocations = 0
    
    func navigate(to screen: any Hashable) {
        path.append(screen)
        navigationParameter = screen
        numberOfNavigationInvocation += 1
    }
    
    func pop() {
        numberOfPopInvocation += 1
    }
    
    func reset() {
        numberOfResetInvocations += 1
    }
}
