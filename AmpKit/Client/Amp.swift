//
//  Amp.swift
//  AmpKit
//
//  Created by Scott Hoyt on 8/4/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public struct Amp {
    private let urlBuilder: UrlBuilder
    private let session: URLSession

    // MARK: Initialization

    init(urlBuilder: UrlBuilder, configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.urlBuilder = urlBuilder
        self.session = URLSession(configuration: configuration)
    }

    init(storefront: Storefront, developerToken: String, configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        let urlBuilder = AmpUrlBuilder(storefront: storefront, developerToken: developerToken)
        self.init(urlBuilder: urlBuilder, configuration: configuration)
    }

    // MARK: Requests

    func searchRequest(term: String, limit: Int? = nil, types: [MediaType]? = nil, completion: ((SearchResults?, Error?) -> Void)?) {
        let request = urlBuilder.searchRequest(term: term, limit: limit, types: types)
        fetch(request, completion: completion)
    }

    // MARK: Helpers

    private func fetch<T: Decodable>(_ request: URLRequest, completion: ((T?, Error?) -> Void)?) {
        session.dataTask(with: request) { (data, response, error) in
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
