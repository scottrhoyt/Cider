//
//  Artwork.swift
//  Cider
//
//  Created by Scott Hoyt on 8/2/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public struct Artwork: Codable {
    public let width: Int
    public let height: Int
    public let url: String
    public let bgColor: String

    public let textColor1: String
    public let textColor2: String
    public let textColor3: String
    public let textColor4: String

    public func url(forWidth width: Int) -> URL? {
        let urlString = url.replacingOccurrences(of: "{w}", with: "\(width)").replacingOccurrences(of: "{h}", with: "\(width)")
        return URL(string: urlString)
    }
}
