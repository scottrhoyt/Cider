//
//  PlayParams.swift
//  AmpKit
//
//  Created by Scott Hoyt on 8/1/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public enum PlayParamsKind: String, Codable {
    case album
    case song
}

public struct PlayParams: Codable {
    let id: String
    let kind: PlayParamsKind
}
