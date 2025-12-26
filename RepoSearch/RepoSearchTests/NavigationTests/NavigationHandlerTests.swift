//
//  NavigationHandlerTests.swift
//  RepoSearchTests
//
//  Created by Belcsik Bence on 2025. 12. 26..
//

import Foundation
import RepoSearchNetworking
import SwiftUI
import Testing

@testable import RepoSearch

@Suite("NavigationHandler tests")
struct NavigationHandlerTests {
    
    @Test("Navigate to given parameter")
    func testNavigateToGivenParameter() {
        // Given
        let givenNavigationParameter = Repository.mock
        let sut = DefaultNavigationHandler()
        
        // When
        sut.navigate(to: givenNavigationParameter)
        
        // Then
        #expect(sut.path.count == 1)
    }
    
    @Test("Navigate to given parameter and then back")
    func testNavigateToGivenParameter_andThenNavigateBack() {
        // Given
        let givenNavigationParameter = Repository.mock
        let sut = DefaultNavigationHandler()
        sut.navigate(to: givenNavigationParameter)
        
        // When
        sut.pop()
        
        // Then
        #expect(sut.path.count == 0)
    }
    
    @Test("Navigate to given parameter and then to another and then back")
    func testNavigateToGivenParameter_andThenToAnother_andThenNavigateBack() {
        // Given
        let givenNavigationParameter = Repository.mock
        let givenAnotherNavigationParameter = Repository(
            id: 1,
            name: "name2",
            fullName: "full name 2",
            description: "description 2",
            htmlUrl: URL(string: "https://github.com")!,
            stargazersCount: 1,
            forksCount: 1,
            language: nil,
            owner: RepositoryOwner(
                id: 1,
                login: "login 2",
                url: "url 2",
                htmlUrl: "html url 2",
                avatarUrl: nil
            ),
            createdAt: "created at 2",
            updatedAt: "updated at 2"
        )
        let sut = DefaultNavigationHandler()
        sut.navigate(to: givenNavigationParameter)
        sut.navigate(to: givenAnotherNavigationParameter)
        
        // When
        sut.pop()
        
        // Then
        #expect(sut.path.count == 1)
    }
    
    @Test("Navigate back when the navigation path is empty")
    func testNavigateBack_whenTheNavigationStackIsEmpty() {
        // Given
        let sut = DefaultNavigationHandler()
        
        // When
        sut.pop()
        
        // Then
        #expect(sut.path.count == 0)
    }
    
    @Test("Returning to the root view")
    func testReturningToTheRootView() {
        // Given
        let givenNavigationParameter = Repository.mock
        let givenAnotherNavigationParameter = Repository(
            id: 1,
            name: "name2",
            fullName: "full name 2",
            description: "description 2",
            htmlUrl: URL(string: "https://github.com")!,
            stargazersCount: 1,
            forksCount: 1,
            language: nil,
            owner: RepositoryOwner(
                id: 1,
                login: "login 2",
                url: "url 2",
                htmlUrl: "html url 2",
                avatarUrl: nil
            ),
            createdAt: "created at 2",
            updatedAt: "updated at 2"
        )
        let sut = DefaultNavigationHandler()
        sut.navigate(to: givenNavigationParameter)
        sut.navigate(to: givenAnotherNavigationParameter)
        
        // When
        sut.reset()
        
        // Then
        #expect(sut.path.count == 0)
    }
}
