//
//  ArtworkTests.swift
//  CiderTests
//
//  Created by Scott Hoyt on 8/6/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import XCTest
@testable import Cider

class ArtworkTests: XCTestCase {
    func testURL() {
        let fetch = fixture(Result<Resource<AlbumAttributes>>.self, name: "album")

        let album = fetch.data[0]
        XCTAssertEqual(album.attributes?.artwork.url(forWidth: 123), URL(string: "https://example.mzstatic.com/image/thumb/Music3/v4/2d/02/4a/2d024aaa-4547-ca71-7ba1-b8f5e1d98256/source/123x123bb.jpg")!)
    }
}
