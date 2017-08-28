//
//  MusicVideoTests.swift
//  CiderTests
//
//  Created by Scott Hoyt on 8/28/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import XCTest
@testable import Cider

class MusicVideoTests: XCTestCase {
    func testMusicVideoFromLookup() throws {
        let lookup = try fixture(ResponseRoot<MusicVideo>.self, name: "musicVideo")

        let musicVideo = lookup.data?.first

        XCTAssertEqual(musicVideo?.id, "405410806")
        XCTAssertEqual(musicVideo?.type, .musicVideos)
        XCTAssertEqual(musicVideo?.href, "/v1/catalog/us/music-videos/405410806")

        let attributes = musicVideo?.attributes

        XCTAssertEqual(attributes?.url, URL(string: "https://itunes.apple.com/us/music-video/smooth-criminal-michael-jacksons-vision/id405410806"))
        XCTAssertEqual(attributes?.name, "Smooth Criminal (Michael Jackson's Vision)")
        XCTAssertEqual(attributes!.genreNames, ["Pop"])
        XCTAssertEqual(attributes?.trackNumber, 11)
        XCTAssertEqual(attributes?.artistName, "Michael Jackson")
        XCTAssertEqual(attributes?.releaseDate, "2013-06-11")
        XCTAssertNotNil(attributes?.artwork)
        XCTAssertNil(attributes?.playParams)

        XCTAssertNotNil(musicVideo?.relationships?.artists.data)
        XCTAssertNotNil(musicVideo?.relationships?.albums.data)
    }
}

#if os(Linux)
    extension MusicVideoTests {
        static var allTests: [(String, (MusicVideoTests) -> () throws -> Void)] {
            return [
                ("testMusicVideoFromLookup", testMusicVideoFromLookup),
            ]
        }
    }
#endif
