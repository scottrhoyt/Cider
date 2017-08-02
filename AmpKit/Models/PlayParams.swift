//
//  PlayParams.swift
//  AmpKit
//
//  Created by Scott Hoyt on 8/1/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

enum PlayParamsKind: String, Codable {
    case album
}

struct PlayParams: Codable {
    let id: String
    let kind: PlayParamsKind
}
