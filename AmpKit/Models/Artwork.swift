//
//  Artwork.swift
//  AmpKit
//
//  Created by Scott Hoyt on 8/2/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public struct Artwork: Codable {
    let bgColor: String
    let height: Int
    let width: Int
    let url: String

    // These might not be optionals
    let textColor1: String?
    let textColor2: String?
    let textColor3: String?
    let textColor4: String?

    public func url(forWidth width: Int) -> URL? {
        let urlString = url.replacingOccurrences(of: "{w}", with: "\(width)").replacingOccurrences(of: "{h}", with: "\(width)")
        return URL(string: urlString)
    }
}
