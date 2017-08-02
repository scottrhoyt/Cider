//
//  AmpUrlBuilder.swift
//  AmpKit
//
//  Created by Scott Hoyt on 8/1/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

enum Storefront: String, Codable {
    case unitedStates = "us"
}

enum MediaType: String, Codable {
    case albums
    case songs
}

struct AmpUrlBuilder {

    // MARK: Inputs

    let storefront: Storefront
    let developerToken: String
    var userToken: String?

    // MARK: Constants

    private struct AppleMusicApi {
        // Base
        static let baseURLScheme = "https"
        static let baseURLString = "api.music.apple.com"
        static let baseURLApiVersion = "v1"

        // Search
        static let searchPath = "catalog/{storefront}/search"
        static let searchTerm = "term"
        static let searchLimit = "limit"
        static let searchTypes = "types"
    }

    private let baseApiUrl: URL = {
        var components = URLComponents()

        components.scheme = AppleMusicApi.baseURLScheme
        components.host = AppleMusicApi.baseURLString
        components.path = AppleMusicApi.baseURLApiVersion


        return components.url!
    }()

    // MARK: Construct urls

    private func seachUrl(term: String, limit: Int? = nil, types: [MediaType]? = nil) -> URL {

        // Construct url path

        var components = URLComponents()

        let searchPath = AppleMusicApi.searchPath.replacingOccurrences(of: "{storefront}", with: storefront.rawValue)
        components.path = searchPath

        // Construct query items

        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: AppleMusicApi.searchTerm, value: term))

        if let limit = limit {
            queryItems.append(URLQueryItem(name: AppleMusicApi.searchLimit, value: String(limit)))
        }

        if let types = types {
            let typesString = types.map { $0.rawValue }.joined(separator: ",")
            queryItems.append(URLQueryItem(name: AppleMusicApi.searchTypes, value: typesString))
        }

        components.queryItems = queryItems

        // Construct final url

        return components.url(relativeTo: baseApiUrl)!
    }

    // MARK: Construct requests
}
