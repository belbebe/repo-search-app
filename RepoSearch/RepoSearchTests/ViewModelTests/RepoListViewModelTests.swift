//
//  RepoListViewModelTests.swift
//  RepoSearchTests
//
//  Created by Belcsik Bence on 2025. 12. 26..
//

import Foundation
import RepoSearchNetworking
import Testing

@testable import RepoSearch

@Suite("RepoListViewModel tests")
struct RepoListViewModelTests {
    
    @Test("Repository list item pressed")
    @MainActor
    func testRepoListItemPressed() {
        // Given
        let givenRepository = Repository.mock
        let givenNavigationHandler = NavigationHandlerInterfaceMock()
        let sut = RepoListViewModel(navigationHandler: givenNavigationHandler)
        
        // When
        sut.repoListItemPressed(with: givenRepository)
        
        // Then
        #expect(givenNavigationHandler.numberOfNavigationInvocation == 1)
        #expect(givenNavigationHandler.navigationParameter as! Repository == givenRepository)
    }
}
