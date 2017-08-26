//
//  CiderClient.swift
//  Cider
//
//  Created by Scott Hoyt on 8/4/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public protocol URLFetcher {
    func fetch(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: URLFetcher {
    public func fetch(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: request, completionHandler: completion)
        task.resume()
    }
}

public struct CiderClient {
    private let urlBuilder: UrlBuilder
    private let fetcher: URLFetcher

    // MARK: URLFetcher

    public static var defaultURLFetcher: URLFetcher {
        return URLSession(configuration: URLSessionConfiguration.default)
    }

    // MARK: Initialization

    init(urlBuilder: UrlBuilder, urlFetcher: URLFetcher = CiderClient.defaultURLFetcher) {
        self.urlBuilder = urlBuilder
        self.fetcher = urlFetcher
    }

    public init(storefront: Storefront, developerToken: String, urlFetcher: URLFetcher = CiderClient.defaultURLFetcher) {
        let urlBuilder = CiderUrlBuilder(storefront: storefront, developerToken: developerToken)
        self.init(urlBuilder: urlBuilder, urlFetcher: urlFetcher)
    }

    // MARK: Requests

    public func search(term: String, limit: Int? = nil, offset: Int? = nil, types: [MediaType]? = nil, completion: ((SearchResponseRoot?, Error?) -> Void)?) {
        let request = urlBuilder.searchRequest(term: term, limit: limit, offset: offset, types: types)
        fetch(request, completion: completion)
    }

    public func searchHints(term: String, limit: Int? = nil, types: [MediaType]? = nil, completion: ((ResponseRoot<SearchHints>?, Error?) -> Void)?) {
        let request = urlBuilder.searchHintsRequest(term: term, limit: limit, types: types)
        fetch(request, completion: completion)
    }

    public func artist(id: String, include: [Include]? = nil, completion: ((ResponseRoot<Artist>?, Error?) -> Void)?) {
        let request = urlBuilder.fetchRequest(mediaType: .artists, id: id, include: include)
        fetch(request, completion: completion)
    }

    public func album(id: String, include: [Include]? = nil, completion: ((ResponseRoot<Album>?, Error?) -> Void)?) {
        let request = urlBuilder.fetchRequest(mediaType: .albums, id: id, include: include)
        fetch(request, completion: completion)
    }

    public func song(id: String, include: [Include]? = nil, completion: ((ResponseRoot<Track>?, Error?) -> Void)?) {
        let request = urlBuilder.fetchRequest(mediaType: .songs, id: id, include: include)
        fetch(request, completion: completion)
    }

    public func playlist(id: String, include: [Include]? = nil, completion: ((ResponseRoot<Playlist>?, Error?) -> Void)?) {
        let request = urlBuilder.fetchRequest(mediaType: .playlists, id: id, include: include)
        fetch(request, completion: completion)
    }

    public func musicVideo(id: String, include: [Include]? = nil, completion: ((ResponseRoot<MusicVideo>?, Error?) -> Void)?) {
        let request = urlBuilder.fetchRequest(mediaType: .musicVideos, id: id, include: include)
        fetch(request, completion: completion)
    }

    public func curator(id: String, include: [Include]? = nil, completion: ((ResponseRoot<Curator>?, Error?) -> Void)?) {
        let request = urlBuilder.fetchRequest(mediaType: .curators, id: id, include: include)
        fetch(request, completion: completion)
    }

    // MARK: Relationships

    public func get<T>(related: Relationship<T>, limit: Int? = nil, offset: Int? = nil, completion: ((ResponseRoot<T>?, Error?) -> Void)?) {
        let path = related.href
        let request = urlBuilder.relationshipRequest(path: path, limit: limit, offset: offset)
        fetch(request, completion: completion)
    }

    // MARK: Helpers

    private func fetch<T: Decodable>(_ request: URLRequest, completion: ((T?, Error?) -> Void)?) {
        fetcher.fetch(request: request) { (data, response, error) in
            guard let data = data else {
                completion?(nil, error)
                return
            }

            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(T.self, from: data)
                completion?(results, nil)
            } catch {
                completion?(nil, error)
            }
        }
    }
}
