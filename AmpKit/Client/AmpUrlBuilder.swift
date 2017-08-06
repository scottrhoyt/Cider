//
//  AmpUrlBuilder.swift
//  AmpKit
//
//  Created by Scott Hoyt on 8/1/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

protocol UrlBuilder {
    func searchRequest(term: String, limit: Int?, types: [MediaType]?) -> URLRequest
}

enum Storefront: String, Codable {
    case unitedStates = "us"
}

public enum AmpUrlBuilderError: Error {
    case noUserToken
}

struct AmpUrlBuilder: UrlBuilder {

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

        // Fetch
        static let artistPath = "v1/catalog/{storefront}/artists/{id}"
        static let albumsPath = "v1/catalog/{storefront}/albums/{id}"
        static let songsPath = "v1/catalog/{storefront}/songs/{id}"
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

        components.path = addStorefront(urlString: AppleMusicApi.searchPath)

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

    private func fetchURL(mediaType: MediaType, id: String) -> URL {
        var components = URLComponents()
        var fetchPath: String

        switch mediaType {
        case .artists: fetchPath = AppleMusicApi.artistPath
        case .albums: fetchPath = AppleMusicApi.albumsPath
        case .songs: fetchPath = AppleMusicApi.songsPath
        }

        components.path = addStorefront(urlString: fetchPath).replacingOccurrences(of: "{id}", with: id)

        return components.url(relativeTo: baseApiUrl)!.absoluteURL
    }

    private func addStorefront(urlString: String) -> String {
        return urlString.replacingOccurrences(of: "{storefront}", with: storefront.rawValue)
    }

    // MARK: Construct requests

    func searchRequest(term: String, limit: Int? = nil, types: [MediaType]? = nil) -> URLRequest {
        let url = seachUrl(term: term, limit: limit, types: types)
        return constructRequest(url: url)
    }

    func fetchRequest(mediaType: MediaType, id: String) -> URLRequest {
        let url = fetchURL(mediaType: mediaType, id: id)
        return constructRequest(url: url)
    }

    private func constructRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeout)
        request = addAuth(request: request)

        return request
    }

    // MARK: Add authentication

    private func addAuth(request: URLRequest) -> URLRequest {
        var request = request

        let authHeader = "Bearer \(developerToken)"
        request.setValue(authHeader, forHTTPHeaderField: "Authorization")

        return request
    }

    private func addUserToken(request: URLRequest) throws -> URLRequest {
        guard let userToken = userToken else {
            throw AmpUrlBuilderError.noUserToken
        }

        var request = request
        request.setValue(userToken, forHTTPHeaderField: "Music-User-Token")

        return request
    }
}

// MARK: - Helpers

private extension String {
    func replaceSpacesWithPluses() -> String {
        return self.replacingOccurrences(of: " ", with: "+")
    }
}
