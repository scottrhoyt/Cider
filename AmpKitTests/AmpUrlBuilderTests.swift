//
//  AmpUrlBuilderTests.swift
//  AmpKitTests
//
//  Created by Scott Hoyt on 8/1/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import XCTest
@testable import AmpKit

class AmpUrlBuilderTests: XCTestCase {

    let limit = 10
    let devToken = "devToken"
    let storefront = Storefront.unitedStates

    var builder: AmpUrlBuilder {
        return AmpUrlBuilder(storefront: storefront, developerToken: devToken)
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

    func testFetchArtistUrl() {
        XCTAssertEqual(builder.fetchURL(mediaType: .artists, id: "id123"), URL(string: "https://api.music.apple.com/v1/catalog/us/artists/id123")!)
    }

    func testFetchAlbumUrl() {
        XCTAssertEqual(builder.fetchURL(mediaType: .albums, id: "id123"), URL(string: "https://api.music.apple.com/v1/catalog/us/albums/id123")!)
    }

    func testFetchSongUrl() {
        XCTAssertEqual(builder.fetchURL(mediaType: .songs, id: "id123"), URL(string: "https://api.music.apple.com/v1/catalog/us/songs/id123")!)
    }
}
