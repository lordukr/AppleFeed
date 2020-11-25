//
//  FeedClient.swift
//  AppleFeed
//
//  Created by azavialov on 25.11.2020.
//

import Foundation
import Combine
import Alamofire

enum FeedClient {
  static let client = ApiClient()
  
}

extension FeedClient {
  static func getFeed() -> AnyPublisher<Feed, AFError>? {
    let route = FeedApiRouter.feed
    
    return client.performRequest(route: route)
  }
}
