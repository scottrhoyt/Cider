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

struct AmpUrlBuilder {

    // MARK: Inputs

    let storefront: Storefront
    let developerToken: String
    var userToken: String?
    private var cachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
    private var timeout: TimeInterval = 5

    // MARK: Init

    init(storefront: Storefront, developerToken: String) {
        self.storefront = storefront
        self.developerToken = developerToken
    }

    // MARK: Constants

    private struct AppleMusicApi {
        // Base
        static let baseURLScheme = "https"
        static let baseURLString = "api.music.apple.com"
        static let baseURLApiVersion = "/v1"

        // Search
        static let searchPath = "v1/catalog/{storefront}/search"
        static let searchTerm = "term"
        static let searchLimit = "limit"
        static let searchTypes = "types"
    }

    private var baseApiUrl: URL {
        var components = URLComponents()

        components.scheme = AppleMusicApi.baseURLScheme
        components.host = AppleMusicApi.baseURLString

        return components.url!
    }

    // MARK: Construct urls

    private func seachUrl(term: String, limit: Int? = nil, types: [MediaType]? = nil) -> URL {

        // Construct url path

        var components = URLComponents()

        let searchPath = AppleMusicApi.searchPath.replacingOccurrences(of: "{storefront}", with: storefront.rawValue)
        components.path = searchPath

        // Construct query items

        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: AppleMusicApi.searchTerm, value: term.replaceSpacesWithPluses()))

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

    func searchRequest(term: String, limit: Int? = nil, types: [MediaType]? = nil) -> URLRequest {
        let url = seachUrl(term: term, limit: limit, types: types)
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeout)
        request = addAuth(request: request)

        return request
    }

    // MARK: Add authentication

    private func addAuth(request: URLRequest) -> URLRequest {
        var request = request

        let authHeader = "bearer \(developerToken)"
        request.setValue(authHeader, forHTTPHeaderField: "Authorization")

        return request
    }
}

// MARK: - Helpers

private extension String {
    func replaceSpacesWithPluses() -> String {
        return self.replacingOccurrences(of: " ", with: "+")
    }
}
