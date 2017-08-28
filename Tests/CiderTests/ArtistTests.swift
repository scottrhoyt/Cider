//
//  ArtistTests.swift
//  CiderTests
//
//  Created by Scott Hoyt on 8/2/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import XCTest
@testable import Cider

class ArtistTests: XCTestCase {
    func testArtistFromSearch() throws {
        let search = try fixture(ResponseRoot<SearchResults>.self, name: "search")

        let artist = search.results!.artists!.data![0]

        XCTAssertEqual(artist.id, "117118")
        XCTAssertEqual(artist.type, .artists)
        XCTAssertEqual(artist.href, "/v1/catalog/us/artists/117118")
        XCTAssertNil(artist.relationships)

        let attributes = artist.attributes!
        XCTAssertEqual(attributes.editorialNotes?.standard, "The Godfather of Soul, The Hardest Working Man in Show Business, Soul Brother Number One . . . Mountain-of-a-man nicknames, no doubt, but not one of them ever did James Brown the justice he deserved. JB’s influence is so large it’s plain impossible to imagine what music today would sound like without him. James didn’t just master soul and funk; he invented them. From the on-bended-knee plea called “Try Me” straight to ground zero of the hip-hop revolution, where his screams, grunts, and funky drummer backboned every cut worth mentioning, Brown was soul power itself, an inspiration to an entire nation. Now that Mr. Dynamite has taken his last sweat-drenched shuffle offstage, we’re all left like an awe-struck Apollo audience — still screaming for just one more encore while trying to take in the force of nature we were blessed to witness. James Brown’s face should be on money. His likeness carved on a mountain. And, most importantly, his music played forever.")
        XCTAssertEqual(attributes.name, "James Brown")
        XCTAssertEqual(attributes.genreNames, ["R&B/Soul"])
        XCTAssertEqual(attributes.url, URL(string: "https://itunes.apple.com/us/artist/james-brown/id117118")!)
    }

    func testArtistFromFetch() throws {
        let fetch = try fixture(ResponseRoot<Artist>.self, name: "artist")

        let artist = fetch.data?.first

        XCTAssertEqual(artist?.id, "32940")
        XCTAssertEqual(artist?.type, .artists)
        XCTAssertEqual(artist?.href, "/v1/catalog/us/artists/32940")

        let attributes = artist?.attributes

        XCTAssertEqual(attributes?.url, URL(string: "https://itunes.apple.com/us/artist/michael-jackson/id32940"))
        XCTAssertEqual(attributes?.name, "Michael Jackson")
        XCTAssertEqual(attributes!.genreNames, ["Pop"])

        XCTAssertNotNil(artist?.relationships)
    }
}

#if os(Linux)
    extension ArtistTests {
        static var allTests: [(String, (ArtistTests) -> () throws -> Void)] {
            return [
                ("testArtistFromSearch", testArtistFromSearch),
                ("testArtistFromFetch", testArtistFromFetch),
            ]
        }
    }
#endif
