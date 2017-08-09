//
//  AppleMusicAPIError.swift
//  Cider
//
//  Created by Scott Hoyt on 8/9/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

struct AppleMusicAPIError: Error, Codable {
    let id: String
    let about: String?
    let status: String
    let code: String
    let title: String
    let detail: String
    // let source: Source
    // let meta: Meta
}
