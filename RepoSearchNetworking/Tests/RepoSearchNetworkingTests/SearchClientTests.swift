import Foundation
import Testing

@testable import RepoSearchNetworking

@Suite("SearchClient tests")
struct SearchClientTests {
    
    @Test("Search repositories test with successful query")
    func testSearchRepositories_withSuccessfulQuery() async throws {
        // Given
        let givenRepository = Repository(
            id: 0,
            name: "name",
            fullName: "full name",
            description: nil,
            htmlUrl: URL(string: "https://github.com")!,
            stargazersCount: 0,
            forksCount: 0,
            language: nil,
            owner: RepositoryOwner(
                id: 0,
                login: "login",
                url: "url",
                htmlUrl: "html url",
                avatarUrl: nil
            ),
            createdAt: "create at",
            updatedAt: "updated at"
        )
        let givenNetworkClient = NetworkClientMock()
        givenNetworkClient.nextResult = .success(
            SearchRepositoriesResponse(
                totalCount: 1,
                incompleteResults: false,
                items: [
                    givenRepository
                ]
            )
        )
        let givenRequest = SearchRepositoriesRequest(query: "test")
        let sut = DefaultSearchClient(network: givenNetworkClient)
        
        // When
        let result = try await sut.searchRepositories(givenRequest)
        
        // Then
        #expect(givenNetworkClient.receivedRequests.count == 1)
        #expect(result.totalCount == 1)
        #expect(result.incompleteResults == false)
        #expect(result.items.count == 1)
        #expect(result.items.first == givenRepository)
    }
    
    @Test("Search repositories test with error query")
    func testSearchRepositories_withErrorQuery() async throws {
        // Given
        let givenNetworkClient = NetworkClientMock()
        givenNetworkClient.nextResult = .failure(NetworkError.invalidResponse)
        let givenRequest = SearchRepositoriesRequest(query: "test")
        let sut = DefaultSearchClient(network: givenNetworkClient)
        
        // When
        do { _ = try await sut.searchRepositories(givenRequest) }
        catch let error {
            // Then
            #expect(givenNetworkClient.receivedRequests.count == 1)
            #expect(error.localizedDescription == NetworkError.invalidResponse.localizedDescription)
        }
    }
}

// MARK: - Helpers
class NetworkClientMock: NetworkClientInterface {
    public private(set) var receivedRequests: [URLRequest] = []
    public var nextResult: Result<Any, Error>?
    
    public init() { }
    
    func send<T: Decodable>(_ request: URLRequest) async throws -> T {
        receivedRequests.append(request)
        
        if let nextResult {
            switch nextResult {
            case .success(let value):
                guard let typed = value as? T else {
                    fatalError("MockNetworkClient: nextResult contains \(type(of: value)) but caller expects \(T.self)")
                }
                return typed
            case .failure(let error):
                throw error
            }
        }
        
        fatalError("MockNetworkClient: no result configured for request \(request)")
    }
}
