//
//  Artwork.swift
//  Cider
//
//  Created by Scott Hoyt on 8/2/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

/// An object that represents an artwork
public struct Artwork: Codable {
    /// The maximum width available for the image
    public let width: Int

    /// The maximum height available for the image
    public let height: Int

    /// The URL to request the image asset. The image file name must be preceded by {w}x{h}, as placeholders for the width and height values
    public let url: String

    /// The average background color of the image
    public let bgColor: String?

    /// The primary text color that may be used if the background color is displayed
    public let textColor1: String?

    /// The secondary text color that may be used if the background color is displayed
    public let textColor2: String?

    /// The tertiary text color that may be used if the background color is displayed
    public let textColor3: String?

    /// The final post-tertiary text color that maybe be used if the background color is displayed
    public let textColor4: String?

    /**
     Returns a `URL` to retrieve the artwork image at a specific width. Most artwork images are square, however for other aspect ratios (e.g. music videos),
     the aspect ratio will be preserved. If you request a width over the maximum width available, you will receive a URL with the maximum width available.

     - parameter forWidth: The width of the image to retrieve. If this is larger than the images maximum `width`, the maximum width will be used.
     - returns: A `URL` for the specified width.
     */
    public func url(forWidth requestedWidth: Int) -> URL? {
        let width = min(requestedWidth, self.width)
        let height = Int(Double(width) * Double(self.height) / Double(self.width))
        let urlString = url.replacingOccurrences(of: "{w}", with: "\(width)").replacingOccurrences(of: "{h}", with: "\(height)")
        return URL(string: urlString)
    }
}
