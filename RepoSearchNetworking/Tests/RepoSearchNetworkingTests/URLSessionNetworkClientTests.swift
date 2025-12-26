//
//  URLSessionNetworkClientTests.swift
//  RepoSearchNetworking
//
//  Created by Belcsik Bence on 2025. 12. 26..
//

import Foundation
import Testing

@testable import RepoSearchNetworking

@Suite("URLSessionNetworkClient tests")
struct URLSessionNetworkClientTests {
    struct DummyResponse: Decodable, Equatable {
        let id: Int
        let userName: String
    }
    
    @Test("Send decodes successful reponse")
    func testSendDecodesSuccessfulResponse() async throws {
        // Given
        let session = makeMockSession()
        let client = URLSessionNetworkClient(session: session)
        
        let url = URL(string: "https://example.com/test")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let body = """
            { "id": 1, "user_name": "john" }
            """.data(using: .utf8)!
        
        URLProtocolMock.requestHandler = { req in
            let response = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, body)
        }
        
        // When
        let result: DummyResponse = try await client.send(request)
        
        // Then
        #expect(result == DummyResponse(id: 1, userName: "john"))
    }
    
    @Test("Send throws on non-2xx status")
    func testSendThrowsOnNon2xxStatus() async throws {
        // Given
        let session = makeMockSession()
        let client = URLSessionNetworkClient(session: session)
        
        let url = URL(string: "https://example.com/error")!
        let request = URLRequest(url: url)
        
        let errorData = Data("error body".utf8)
        
        URLProtocolMock.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: url,
                statusCode: 404,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, errorData)
        }
        
        // When
        do {
            let _: DummyResponse = try await client.send(request)
        } catch let NetworkError.httpStatus(status, data) {
            // Then
            #expect(status == 404)
            #expect(data == errorData)
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }
    
    @Test("Send throws on non-HTTP URL response")
    func testSendThrowsOnNonHTTPURLResponse() async throws {
        // Given
        let session = makeMockSession()
        let client = URLSessionNetworkClient(session: session)
        
        let url = URL(string: "custom-scheme://something")!
        let request = URLRequest(url: url)
        
        URLProtocolMock.requestHandler = { _ in
            let response = URLResponse(
                url: url,
                mimeType: nil,
                expectedContentLength: 0,
                textEncodingName: nil
            )
            throw URLError(.badServerResponse)
        }
        
        // When
        do {
            let _: DummyResponse = try await client.send(request)
        } catch let error {
            // Then
            #expect(error.localizedDescription == NetworkError.invalidResponse.localizedDescription)
        }
    }
    
    @Test("Send propagates decoding error")
    func testSendPropagatesDecodingError() async throws {
        let session = makeMockSession()
        let client = URLSessionNetworkClient(session: session)
        
        let url = URL(string: "https://example.com/invalid")!
        let request = URLRequest(url: url)
        
        let invalidJSON = Data("not json".utf8)
        
        URLProtocolMock.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, invalidJSON)
        }
        
        do {
            let _: DummyResponse = try await client.send(request)
        } catch is DecodingError {
            // Then
            #expect(true)
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
}

// MARK: - Helpers
final class URLProtocolMock: URLProtocol {
    nonisolated(unsafe) static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        guard let handler = URLProtocolMock.requestHandler else {
            fatalError("MockURLProtocol.requestHandler not set")
        }

        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() { }
}

extension URLSessionNetworkClientTests {
    func makeMockSession() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: config)
    }
}
