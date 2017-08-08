//
//  AlbumTests.swift
//  AmpKitTests
//
//  Created by Scott Hoyt on 8/1/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import XCTest
@testable import Cider

class AlbumTests: XCTestCase {
    func testAlbumFromSearch() {
        let search = fixture(SearchResults.self, name: "search")

        let album = search.results.albums!.data[0]

        XCTAssertEqual(album.id, "900721190")
        XCTAssertEqual(album.type, .albums)
        XCTAssertEqual(album.href, "/v1/catalog/us/albums/900721190")
        XCTAssertNil(album.relationships)

        let attributes = album.attributes!
        XCTAssertEqual(attributes.artistName, "James Brown")
        XCTAssertEqual(attributes.name, "20 All-Time Greatest Hits!")
        XCTAssertEqual(attributes.copyright, "℗ 1991 Universal Records, a Division of UMG Recordings, Inc.")
        XCTAssertEqual(attributes.genreNames, ["Soul", "Music", "R&B/Soul", "Funk"])
        XCTAssertEqual(attributes.isComplete, true)
        XCTAssertEqual(attributes.isSingle, false)
        XCTAssertEqual(attributes.releaseDate, "1991-10-22")
        XCTAssertEqual(attributes.trackCount, 20)
        XCTAssertEqual(attributes.url, URL(string: "https://itunes.apple.com/us/album/20-all-time-greatest-hits/id900721190")!)

        XCTAssertEqual(attributes.artwork.bgColor, "ffffff")
        XCTAssertEqual(attributes.artwork.height, 1400)
        XCTAssertEqual(attributes.artwork.textColor1, "0a0a09")
        XCTAssertEqual(attributes.artwork.textColor2, "2a240f")
        XCTAssertEqual(attributes.artwork.textColor3, "3b3b3a")
        XCTAssertEqual(attributes.artwork.textColor4, "544f3f")
        XCTAssertEqual(attributes.artwork.url, "https://example.mzstatic.com/image/thumb/Music4/v4/76/85/e5/7685e5c8-9346-88db-95ff-af87bf84151b/source/{w}x{h}bb.jpg")
        XCTAssertEqual(attributes.artwork.width, 1400)

        XCTAssertEqual(attributes.playParams.id, "900721190")
        XCTAssertEqual(attributes.playParams.kind, .album)

        XCTAssertNil(attributes.editorialNotes)
    }

    func testAlbumFromFetch() {
        let fetch = fixture(Result<MediaResult<AlbumAttributes>>.self, name: "album")

        let album = fetch.data[0]

        XCTAssertEqual(album.id, "310730204")
        XCTAssertEqual(album.type, .albums)
        XCTAssertEqual(album.href, "/v1/catalog/us/albums/310730204")

        let attributes = album.attributes!
        XCTAssertEqual(attributes.artistName, "Bruce Springsteen")
        XCTAssertEqual(attributes.name, "Born to Run")
        XCTAssertEqual(attributes.copyright, "℗ 1975 Bruce Springsteen")
        XCTAssertEqual(attributes.genreNames, [
            "Rock",
            "Music",
            "Arena Rock",
            "Rock & Roll",
            "Pop",
            "Pop/Rock"
            ])
        XCTAssertEqual(attributes.isComplete, true)
        XCTAssertEqual(attributes.isSingle, false)
        XCTAssertEqual(attributes.releaseDate, "1975-08-25")
        XCTAssertEqual(attributes.trackCount, 8)
        XCTAssertEqual(attributes.url, URL(string: "https://itunes.apple.com/us/album/born-to-run/id310730204")!)

        XCTAssertEqual(attributes.artwork.bgColor, "ffffff")
        XCTAssertEqual(attributes.artwork.height, 1500)
        XCTAssertEqual(attributes.artwork.textColor1, "0c0b09")
        XCTAssertEqual(attributes.artwork.textColor2, "2a2724")
        XCTAssertEqual(attributes.artwork.textColor3, "3d3c3a")
        XCTAssertEqual(attributes.artwork.textColor4, "555250")
        XCTAssertEqual(attributes.artwork.url, "https://example.mzstatic.com/image/thumb/Music3/v4/2d/02/4a/2d024aaa-4547-ca71-7ba1-b8f5e1d98256/source/{w}x{h}bb.jpg")
        XCTAssertEqual(attributes.artwork.width, 1500)

        XCTAssertEqual(attributes.playParams.id, "310730204")
        XCTAssertEqual(attributes.playParams.kind, .album)

        XCTAssertEqual(attributes.editorialNotes?.standard, "Springsteen's third album was the one that broke it all open for him, planting his tales of Jersey girls, cars, and nights spent sleeping on the beach firmly in the Top Five. He shot for an unholy hybrid of Orbison, Dylan and Spector — and actually reached it. \"Come take my hand,\" he invited in the opening lines. \"We're ridin' out tonight to case the Promised Land.\" Soon after this album, he'd discover the limits of such dreams, but here, it's a wide-open road: Even the tales of petty crime (\"Meeting Across the River\") and teen-gang violence (\"Jungleland\") are invested with all the wit and charm you can handle. Bruce's catalog is filled with one-of-a-kind albums from <i>The Wild, The Innocent and the E Street Shuffle</i> to <i>The Ghost of Tom Joad</i>. Forty years on, <i>Born to Run</i> still sits near the very top of that stack.")
        XCTAssertEqual(attributes.editorialNotes?.short, "Springsteen's third album was the one that broke it all open for him.")
    }
}
