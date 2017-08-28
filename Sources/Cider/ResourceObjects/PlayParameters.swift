//
//  PlayParameters.swift
//  Cider
//
//  Created by Scott Hoyt on 8/1/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

/// An object that represents play parameters for resources.
public struct PlayParameters: Codable {
    /// The ID of the content to use for playback
    public let id: String

    /// The kind of the content to use for playback
    public let kind: String
}
