//
//  FeedApiRouter.swift
//  AppleFeed
//
//  Created by azavialov on 25.11.2020.
//

import Foundation

enum FeedApiRouter: APIConfiguration {
  case feed
  
  var method: HTTPMethod {
    switch self {
    case .feed:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .feed:
      return "breaking_news.rss"
    }
  }
  
  var parameters: [String : AnyHashable]? {
    switch self {
    case .feed:
      return nil
    }
  }
}
