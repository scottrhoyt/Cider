//
//  XCTestCase+Helpers.swift
//  AmpKitTests
//
//  Created by Scott Hoyt on 8/2/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import XCTest

extension XCTestCase {
    func fixture<T: Decodable>(_ type: T.Type, name: String, fileType: String = "json") -> T {
        let url = Bundle(for: AlbumTests.self).url(forResource: name, withExtension: fileType)!
        let data = try! Data(contentsOf: url)

        let decoder = JSONDecoder()
        return try! decoder.decode(T.self, from: data)
    }
}
