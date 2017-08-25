//
//  CiderUrlBuilder.swift
//  Cider
//
//  Created by Scott Hoyt on 8/1/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

protocol UrlBuilder {
    func searchRequest(term: String, limit: Int?, offset: Int?, types: [MediaType]?) -> URLRequest
    func fetchRequest(mediaType: MediaType, id: String, include: [Include]?) -> URLRequest
    func relationshipRequest(path: String, limit: Int?, offset: Int?) -> URLRequest
}

public enum Storefront: String, Codable {
    case unitedStates = "us"
}

public enum CiderUrlBuilderError: Error {
    case noUserToken
}

// MARK: - Constants

private struct AppleMusicApi {
    // Base
    static let baseURLScheme = "https"
    static let baseURLString = "api.music.apple.com"
    static let baseURLApiVersion = "/v1"

    // Search
    static let searchPath = "v1/catalog/{storefront}/search"
    static let searchTerm = "term"
    static let searchLimit = "limit"
    static let searchOffset = "offset"
    static let searchTypes = "types"

    // Fetch
    static let fetchPath = "v1/catalog/{storefront}/{mediaType}/{id}"
    static let fetchInclude = "include"
}

// MARK: - UrlBuilder

struct CiderUrlBuilder: UrlBuilder {

    // MARK: Inputs

    let storefront: Storefront
    let developerToken: String
    var userToken: String?
    private let cachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy
    private let timeout: TimeInterval = 5

    // MARK: Init

    init(storefront: Storefront, developerToken: String) {
        self.storefront = storefront
        self.developerToken = developerToken
    }

    private var baseApiUrl: URL {
        var components = URLComponents()

        components.scheme = AppleMusicApi.baseURLScheme
        components.host = AppleMusicApi.baseURLString

        return components.url!
    }

    // MARK: Construct urls

    private func seachUrl(term: String, limit: Int?, offset: Int?, types: [MediaType]?) -> URL {

        // Construct url path

        var components = URLComponents()

        components.path = AppleMusicApi.searchPath.addStorefront(storefront)

        // Construct Query
        components.apply(searchTerm: term)
        components.apply(limit: limit)
        components.apply(offset: offset)
        components.apply(mediaTypes: types)

        // Construct final url
        return components.url(relativeTo: baseApiUrl)!
    }

    private func fetchURL(mediaType: MediaType, id: String, include: [Include]?) -> URL {
        var components = URLComponents()

        components.path = AppleMusicApi.fetchPath.addStorefront(storefront).addMediaType(mediaType).addId(id)
        components.apply(include: include)

        return components.url(relativeTo: baseApiUrl)!.absoluteURL
    }

    private func relationshipURL(path: String, limit: Int?, offset: Int?) -> URL {
        var components = URLComponents()

        components.path = path
        components.apply(limit: limit)
        components.apply(offset: offset)

        return components.url(relativeTo: baseApiUrl)!.absoluteURL
    }

    // MARK: Construct requests

    func searchRequest(term: String, limit: Int?, offset: Int?, types: [MediaType]?) -> URLRequest {
        let url = seachUrl(term: term, limit: limit, offset: offset, types: types)
        return constructRequest(url: url)
    }

    func fetchRequest(mediaType: MediaType, id: String, include: [Include]?) -> URLRequest {
        let url = fetchURL(mediaType: mediaType, id: id, include: include)
        return constructRequest(url: url)
    }

    func relationshipRequest(path: String, limit: Int?, offset: Int?) -> URLRequest {
        let url = relationshipURL(path: path, limit: limit, offset: offset)
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

    func addUserToken(request: URLRequest) throws -> URLRequest {
        guard let userToken = userToken else {
            throw CiderUrlBuilderError.noUserToken
        }

        var request = request
        request.setValue(userToken, forHTTPHeaderField: "Music-User-Token")

        return request
    }
}

// MARK: - Helpers

private extension String {
    func replaceSpacesWithPluses() -> String {
        return replacingOccurrences(of: " ", with: "+")
    }

    func addStorefront(_ storefront: Storefront) -> String {
        return replacingOccurrences(of: "{storefront}", with: storefront.rawValue)
    }

    func addId(_ id: String) -> String {
        return replacingOccurrences(of: "{id}", with: id)
    }

    func addMediaType(_ mediaType: MediaType) -> String {
        return replacingOccurrences(of: "{mediaType}", with: mediaType.rawValue)
    }
}

private extension URLComponents {
    mutating func createQueryItemsIfNeeded() {
        if queryItems == nil {
            queryItems = []
        }
    }

    mutating func apply(searchTerm: String) {
        createQueryItemsIfNeeded()
        queryItems?.append(URLQueryItem(name: AppleMusicApi.searchTerm, value: searchTerm.replaceSpacesWithPluses()))
    }

    mutating func apply(mediaTypes: [MediaType]?) {
        guard let mediaTypes = mediaTypes else { return }

        createQueryItemsIfNeeded()
        queryItems?.append(URLQueryItem(name: AppleMusicApi.searchTypes, value: mediaTypes.map { $0.rawValue }.joined(separator: ",")))
    }

    mutating func apply(limit: Int?) {
        guard let limit = limit else { return }

        createQueryItemsIfNeeded()
        queryItems?.append(URLQueryItem(name: AppleMusicApi.searchLimit, value: "\(limit)"))
    }

    mutating func apply(offset: Int?) {
        guard let offset = offset else { return }

        createQueryItemsIfNeeded()
        queryItems?.append(URLQueryItem(name: AppleMusicApi.searchOffset, value: "\(offset)"))
    }

    mutating func apply(include: [Include]?) {
        guard let include = include else { return }

        createQueryItemsIfNeeded()
        queryItems?.append(URLQueryItem(name: AppleMusicApi.fetchInclude, value: include.map { $0.rawValue }.joined(separator: ",")))
    }
}
