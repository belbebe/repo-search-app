//
//  RepoSearchApp.swift
//  RepoSearch
//
//  Created by Belcsik Bence on 2025. 12. 10..
//

import SwiftUI

@main
struct RepoSearchApp: App {
    @StateObject private var navigationHandler = DefaultNavigationHandler()
    @StateObject private var container = DIContainer.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationHandler)
                .environmentObject(container)
        }
    }
}
