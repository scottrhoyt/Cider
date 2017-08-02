//
//  AlbumTests.swift
//  AmpKitTests
//
//  Created by Scott Hoyt on 8/1/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import XCTest
@testable import AmpKit

class AlbumTests: XCTestCase {
    func testAlbum() {
        let search = fixture(SearchResults.self, name: "search")

        let album = search.results.albums!.data[0]

        XCTAssertEqual(album.id, "900721190")
        XCTAssertEqual(album.type, .albums)
        XCTAssertEqual(album.href, "/v1/catalog/us/albums/900721190")

        XCTAssertEqual(album.attributes.artistName, "James Brown")
        XCTAssertEqual(album.attributes.name, "20 All-Time Greatest Hits!")
        XCTAssertEqual(album.attributes.copyright, "℗ 1991 Universal Records, a Division of UMG Recordings, Inc.")
        XCTAssertEqual(album.attributes.genreNames, ["Soul", "Music", "R&B/Soul", "Funk"])
        XCTAssertEqual(album.attributes.isComplete, true)
        XCTAssertEqual(album.attributes.isSingle, false)
        XCTAssertEqual(album.attributes.releaseDate, "1991-10-22")
        XCTAssertEqual(album.attributes.trackCount, 20)
        XCTAssertEqual(album.attributes.url, URL(string: "https://itunes.apple.com/us/album/20-all-time-greatest-hits/id900721190")!)

        XCTAssertEqual(album.attributes.artwork.bgColor, "ffffff")
        XCTAssertEqual(album.attributes.artwork.height, 1400)
        XCTAssertEqual(album.attributes.artwork.textColor1, "0a0a09")
        XCTAssertEqual(album.attributes.artwork.textColor2, "2a240f")
        XCTAssertEqual(album.attributes.artwork.textColor3, "3b3b3a")
        XCTAssertEqual(album.attributes.artwork.textColor4, "544f3f")
        XCTAssertEqual(album.attributes.artwork.url, "https://example.mzstatic.com/image/thumb/Music4/v4/76/85/e5/7685e5c8-9346-88db-95ff-af87bf84151b/source/{w}x{h}bb.jpg")
        XCTAssertEqual(album.attributes.artwork.width, 1400)

        XCTAssertEqual(album.attributes.playParams.id, "900721190")
        XCTAssertEqual(album.attributes.playParams.kind, .album)

        XCTAssertNil(album.attributes.editorialNotes)
    }
}
