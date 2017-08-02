//
//  Artwork.swift
//  AmpKit
//
//  Created by Scott Hoyt on 8/2/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

struct Artwork: Codable {
    let bgColor: String
    let height: Int
    let width: Int
    let url: String

    // These might not be optionals
    let textColor1: String?
    let textColor2: String?
    let textColor3: String?
    let textColor4: String?
}
