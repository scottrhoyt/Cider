//
//  PlaylistTests.swift
//  CiderTests
//
//  Created by Scott Hoyt on 8/28/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import XCTest
@testable import Cider

class PlaylistTests: XCTestCase {
    func testPlaylistFromLookup() throws {
        let lookup = try fixture(ResponseRoot<Playlist>.self, name: "playlist")

        let playlist = lookup.data?.first

        XCTAssertEqual(playlist?.id, "pl.f475b81eaf7546ffb8ffd20889f37032")
        XCTAssertEqual(playlist?.type, .playlists)
        XCTAssertEqual(playlist?.href, "/v1/catalog/us/playlists/pl.f475b81eaf7546ffb8ffd20889f37032")

        let attributes = playlist?.attributes

        XCTAssertEqual(attributes?.description?.standard, "A child prodigy who became a global superstar, Michael Jackson transformed pop culture with his groundbreaking music and spectacular performances. After first scoring with the Jackson 5, he embarked on his solo career in the early '70s. He teamed with producer Quincy Jones on two beyond-massive hits—1979's disco-meets-funk smash Off the Wall and 1982's genre-busting Thriller—and became The King of Pop. Four more chart-topping albums followed before his tragic death in 2009, but thanks to a catalog packed with classics, Jackson's music continues to thrill fans around the world.")
        XCTAssertEqual(attributes?.description?.short, "Epic hits from the once and future King of Pop.")
        XCTAssertEqual(attributes?.url, URL(string: "https://itunes.apple.com/us/playlist/michael-jackson-essentials/idpl.f475b81eaf7546ffb8ffd20889f37032"))
        XCTAssertEqual(attributes?.name, "Michael Jackson Essentials")
        XCTAssertEqual(attributes?.playlistType, .editorial)
        XCTAssertEqual(attributes?.lastModifiedDate, "2016-12-02T22:06:54Z")
        XCTAssertEqual(attributes?.curatorName, "Apple Music Pop")
        XCTAssertNotNil(attributes?.artwork)
        XCTAssertEqual(attributes?.playParams?.id, "pl.f475b81eaf7546ffb8ffd20889f37032")
        XCTAssertEqual(attributes?.playParams?.kind, "playlist")

        XCTAssertNotNil(playlist?.relationships?.curator.data)
        XCTAssertNotNil(playlist?.relationships?.tracks.data)
        XCTAssertEqual(playlist?.relationships?.tracks.data?.count, 25)
    }
}

#if os(Linux)
    extension PlaylistTests {
        static var allTests: [(String, (PlaylistTests) -> () throws -> Void)] {
            return [
                ("testPlaylistFromLookup", testPlaylistFromLookup),
            ]
        }
    }
#endif
