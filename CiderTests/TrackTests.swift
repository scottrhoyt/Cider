//
//  TrackTests.swift
//  CiderTests
//
//  Created by Scott Hoyt on 8/4/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import XCTest
@testable import Cider

class TrackTests: XCTestCase {
    func testTrackFromFetch() {
        let result = fixture(Result<MediaResult<TrackAttributes>>.self, name: "song")

        let track = result.data[0]

        XCTAssertEqual(track.id, "900032829")
        XCTAssertEqual(track.type, .songs)
        XCTAssertEqual(track.href, "/v1/catalog/us/songs/900032829")
        XCTAssertNotNil(track.relationships)

        // album relationship
        XCTAssertEqual(track.relationships?.albums?.data[0].href, "/v1/catalog/us/albums/900032785")
        XCTAssertEqual(track.relationships?.albums?.data[0].id, "900032785")
        XCTAssertEqual(track.relationships?.albums?.data[0].type, .albums)

        let attributes = track.attributes!
        XCTAssertEqual(attributes.artistName, "Michael de Jong")

        // artist relationships
        XCTAssertEqual(track.relationships?.artists?.data[0].href, "/v1/catalog/us/artists/6671250")
        XCTAssertEqual(track.relationships?.artists?.data[0].id, "6671250")
        XCTAssertEqual(track.relationships?.artists?.data[0].type, .artists)

        // artwork
        let artwork = attributes.artwork
        XCTAssertEqual(artwork.bgColor, "346687")
        XCTAssertEqual(artwork.height, 2400)
        XCTAssertEqual(artwork.textColor1, "c9fcf0")
        XCTAssertEqual(artwork.textColor2, "b4fbf3")
        XCTAssertEqual(artwork.textColor3, "abdedb")
        XCTAssertEqual(artwork.textColor4, "9bdddd")

        XCTAssertEqual(attributes.composerName, "Michael de Jong")
        XCTAssertEqual(attributes.discNumber, 1)
        XCTAssertEqual(attributes.durationInMillis, 327693)
        XCTAssertEqual(attributes.genreNames, ["Singer/Songwriter", "Music", "Blues"])
        XCTAssertEqual(attributes.name, "Something For the Pain")

        // Play params
        XCTAssertEqual(attributes.playParams?.id, "900032829")
        XCTAssertEqual(attributes.playParams?.kind, "song")


        XCTAssertEqual(attributes.releaseDate, "2014-07-11")
        XCTAssertEqual(attributes.trackNumber, 7)
        XCTAssertEqual(attributes.url, URL(string: "https://itunes.apple.com/us/album/something-for-the-pain/id900032785?i=900032829")!)
    }
}
