//
//  CiderUrlBuilderTests.swift
//  CiderTests
//
//  Created by Scott Hoyt on 8/1/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import XCTest
@testable import Cider

class CiderUrlBuilderTests: XCTestCase {

    let limit = 10
    let devToken = "devToken"
    let storefront = Storefront.unitedStates

    var builder: CiderUrlBuilder {
        return CiderUrlBuilder(storefront: storefront, developerToken: devToken)
    }

    // MARK: - Search

    let term = "search term"
    let types = [MediaType.albums, MediaType.songs]

    var searchRequest: URLRequest {
        return builder.searchRequest(term: term, limit: limit, types: types)
    }

    func testSearchRequestUrl() {
        XCTAssertEqual(searchRequest.url?.absoluteString, "https://api.music.apple.com/v1/catalog/us/search?term=search+term&limit=10&types=albums,songs")
    }

    func testSearchRequestHeaders() {
        XCTAssertEqual(searchRequest.allHTTPHeaderFields!, ["Authorization": "Bearer devToken"])
    }

    func testSearchRequestMethod() {
        XCTAssertEqual(searchRequest.httpMethod, "GET")
    }

    // MARK: - Fetch

    func testFetchArtistRequest() {
        var request = builder.fetchRequest(mediaType: .artists, id: "id123")
        XCTAssertEqual(request.url, URL(string: "https://api.music.apple.com/v1/catalog/us/artists/id123")!)
        XCTAssertEqual(request.allHTTPHeaderFields!, ["Authorization": "Bearer devToken"])
    }

    func testFetchAlbumRequest() {
        var request = builder.fetchRequest(mediaType: .albums, id: "id123")
        XCTAssertEqual(request.url, URL(string: "https://api.music.apple.com/v1/catalog/us/albums/id123")!)
        XCTAssertEqual(request.allHTTPHeaderFields!, ["Authorization": "Bearer devToken"])
    }

    func testFetchSongRequest() {
        var request = builder.fetchRequest(mediaType: .songs, id: "id123")
        XCTAssertEqual(request.url, URL(string: "https://api.music.apple.com/v1/catalog/us/songs/id123")!)
        XCTAssertEqual(request.allHTTPHeaderFields!, ["Authorization": "Bearer devToken"])
    }

    func testFetchAlbumRequestWithInclude() {
        var request = builder.fetchRequest(mediaType: .albums, id: "id123", include: [.artists, .tracks])
        XCTAssertEqual(request.url, URL(string: "https://api.music.apple.com/v1/catalog/us/albums/id123?include=artists,tracks")!)
        XCTAssertEqual(request.allHTTPHeaderFields!, ["Authorization": "Bearer devToken"])
    }

    func testAddUserToken() {
        var myBuilder = builder
        myBuilder.userToken = "user_token"
        var request = URLRequest(url: URL(string: "http://example.com")!)
        request = try! myBuilder.addUserToken(request: request)
        XCTAssertEqual(request.allHTTPHeaderFields!, ["Music-User-Token": "user_token"])
    }

    func testAddUserTokenThrowsWithNoToken() {
        var request = URLRequest(url: URL(string: "http://example.com")!)
        do {
            request = try builder.addUserToken(request: request)
        } catch(CiderUrlBuilderError.noUserToken) {
            return
        } catch {
            XCTFail("Threw the wrong error.")
        }
    }
}

#if os(Linux)
    extension CiderUrlBuilderTests {
        static var allTests: [(String, (CiderUrlBuilderTests) -> () throws -> Void)] {
            return [
                ("testSearchRequestUrl", testSearchRequestUrl),
                ("testSearchRequestHeaders", testSearchRequestHeaders),
                ("testSearchRequestMethod", testSearchRequestMethod),
                ("testFetchArtistRequest", testFetchArtistRequest),
                ("testFetchAlbumRequest", testFetchAlbumRequest),
                ("testFetchSongRequest", testFetchSongRequest),
                ("testFetchAlbumRequestWithInclude", testFetchAlbumRequestWithInclude),
            ]
        }
    }
#endif
