//
//  ContentViewModelTests.swift
//  RepoSearchTests
//
//  Created by Belcsik Bence on 2025. 12. 22..
//

import Foundation
import RepoSearchNetworking
import Testing

@testable import RepoSearch

@Suite("ContentViewModel tests")
struct ContentViewModelTests {
    
    @Test("Search button pressed when search text is empty")
    @MainActor
    func testSearchButtonPress_whenSearchTextIsEmpty() async throws {
        // Given
        let givenSearchClientMock = SearchClientInterfaceMock()
        let sut = ContentViewModel(client: givenSearchClientMock)
        sut.searchText = ""
        
        // When
        await sut.searchButtonPressed()
        
        // Then
        #expect(sut.repositories.count == 0)
        #expect(givenSearchClientMock.requests.count == 0)
        #expect(sut.errorMessage == nil)
    }

    @Test("Search button pressed when search text is NOT empty but navigation handler is nil")
    @MainActor
    func testSearchButtonPress_whenSearchTextIsNotEmpty_andNavigationHandlerIsNil() async throws {
        // Given
        let givenSearchClientMock = SearchClientInterfaceMock()
        givenSearchClientMock.mockResponse = SearchRepositoriesResponse(
            totalCount: 1,
            incompleteResults: false,
            items: [
                Repository.mock
            ])
        let sut = ContentViewModel(client: givenSearchClientMock)
        sut.navigationHandler = nil
        sut.searchText = "example"
        
        // When
        await sut.searchButtonPressed()
        
        // Then
        #expect(sut.repositories.count == 0)
        #expect(givenSearchClientMock.requests.count == 0)
        #expect(sut.errorMessage == nil)
    }
    
    @Test("Search button pressed when search text is NOT empty and navigation handler is NOT nil but endpoint returns error")
    @MainActor
    func testSearchButtonPress_whenSearchTextIsNotEmpty_andNavigationHandlerIsNotNil_andEndpointReturnsError() async throws {
        // Given
        let givenSearchClientMock = SearchClientInterfaceMock()
        let givenNavigationHandler = NavigationHandlerInterfaceMock()
        let givenError = URLError(.badServerResponse)
        givenSearchClientMock.mockError = givenError
        let sut = ContentViewModel(client: givenSearchClientMock)
        sut.navigationHandler = givenNavigationHandler
        sut.searchText = "example"
        
        // When
        await sut.searchButtonPressed()
        
        // Then
        #expect(sut.repositories.count == 0)
        #expect(givenSearchClientMock.requests.count == 1)
        #expect(givenNavigationHandler.numberOfNavigationInvocation == 0)
        #expect(sut.errorMessage == givenError.localizedDescription)
    }
    
    @Test("Search button pressed when search text is NOT empty and navigation handler is NOT nil and endpoint returns success response")
    @MainActor
    func testSearchButtonPress_whenSearchTextIsNotEmpty_andNavigationHandlerIsNotNil() async throws {
        // Given
        let givenSearchClientMock = SearchClientInterfaceMock()
        let givenRepository = Repository.mock
        let givenMockResponse = SearchRepositoriesResponse(
            totalCount: 1,
            incompleteResults: false,
            items: [
                givenRepository
            ])
        givenSearchClientMock.mockResponse = givenMockResponse
        let givenNavigationHandler = NavigationHandlerInterfaceMock()
        let sut = ContentViewModel(client: givenSearchClientMock)
        sut.navigationHandler = givenNavigationHandler
        sut.searchText = "example"
        
        // When
        await sut.searchButtonPressed()
        
        // Then
        #expect(sut.repositories.count == 1)
        #expect(sut.repositories.first == givenRepository)
        #expect(givenSearchClientMock.requests.count == 1)
        #expect(givenNavigationHandler.numberOfNavigationInvocation == 1)
        #expect(givenNavigationHandler.navigationParameter as! [Repository] == givenMockResponse.items)
        #expect(sut.errorMessage == nil)
    }
}
