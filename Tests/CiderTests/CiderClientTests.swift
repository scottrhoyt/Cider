//
//  CiderClientTests.swift
//  CiderTests
//
//  Created by Scott Hoyt on 8/26/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import XCTest
@testable import Cider

// MARK: - MockUrlFetcher

struct MockUrlFetcher: UrlFetcher {
    var data: Data?
    var error: Error?
    let expectedRequest: URLRequest

    func fetch(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        XCTAssertEqual(request, expectedRequest)
        completion(data, error)
    }
}

// MARK: - MockUrlBuilder

struct MockUrlBuilder: UrlBuilder {
    static let searchRequest = URLRequest(url: URL(string: "http://search.com")!)
    static let searchHintsRequest = URLRequest(url: URL(string: "http://searchHint.com")!)
    static let fetchRequest = URLRequest(url: URL(string: "http://fetch.com")!)
    static let relationshipRequest = URLRequest(url: URL(string: "http://relationship.com")!)

    func searchRequest(term: String, limit: Int?, offset: Int?, types: [MediaType]?) -> URLRequest {
        return MockUrlBuilder.searchRequest
    }

    func searchHintsRequest(term: String, limit: Int?, types: [MediaType]?) -> URLRequest {
        return MockUrlBuilder.searchHintsRequest
    }

    func fetchRequest(mediaType: MediaType, id: String, include: [Include]?) -> URLRequest {
        return MockUrlBuilder.fetchRequest
    }

    func relationshipRequest(path: String, limit: Int?, offset: Int?) -> URLRequest {
        return MockUrlBuilder.relationshipRequest
    }
}

// MARK: - Tests

class CiderClientTests: XCTestCase {
    func testSearch() throws {
        let data = try fixtureData(name: "search")
        let expectedRequest = MockUrlBuilder.searchRequest
        let client = CiderClient(urlBuilder: MockUrlBuilder(), urlFetcher: MockUrlFetcher(data: data, error: nil, expectedRequest: expectedRequest))
        
        client.search(term: "") { (result, error) in
            XCTAssertNil(error)
            XCTAssertEqual(result?.results.albums?.data?[0].id, "900721190")
        }
    }

    func testSearchHints() {
        // TODO: Extract this to a fixture
        let data = """
        {
            "results": {
                "terms": [
                    "love on the brain",
                    "love me now"
                ]
            }
        }
        """.data(using: .utf8)

        let expectedRequest = MockUrlBuilder.searchHintsRequest
        let client = CiderClient(urlBuilder: MockUrlBuilder(), urlFetcher: MockUrlFetcher(data: data, error: nil, expectedRequest: expectedRequest))

        client.searchHints(term: "") { (result, error) in
            XCTAssertNil(error)
            XCTAssertEqual(result!.results!.terms, ["love on the brain", "love me now"])
        }
    }
}

#if os(Linux)
    extension CiderClientTests {
        static var allTests: [(String, (CiderClientTests) -> () throws -> Void)] {
            return [
                ("testSearch", testSearch),
                ("testSearchHints", testSearchHints),
            ]
        }
    }
#endif
