//
//  AppleMusicAPIError.swift
//  Cider
//
//  Created by Scott Hoyt on 8/9/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public struct AppleMusicAPIError: Error, Codable {
    public let id: String
    public let about: String?
    public let status: String
    public let code: String
    public let title: String
    public let detail: String
    // let source: Source
    // let meta: Meta
}
