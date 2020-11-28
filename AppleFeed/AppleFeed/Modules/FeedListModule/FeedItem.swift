//
//  Feed.swift
//  AppleFeed
//
//  Created by azavialov on 25.11.2020.
//

import Foundation
import XMLCoder

struct Feed: Decodable {
  var feedItems: [FeedItem]
  
  enum CodingKeys: String, CodingKey {
    case feedItems = "channel"
  }
  
  enum FeedItems: String, CodingKey {
    case entry = "item"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let nested = try container.nestedContainer(keyedBy: FeedItems.self, forKey: .feedItems)
    feedItems = try nested.decode([FeedItem].self, forKey: .entry)
  }
}

struct FeedItem: Decodable, DynamicNodeDecoding {
  struct FeedURL: Decodable, DynamicNodeDecoding {
    var url: String
    var type: String
    
    private enum CodingKeys: String, CodingKey {
      case url
      case type
    }
    
    static func nodeDecoding(for key: CodingKey) -> XMLDecoder.NodeDecoding {
      return .elementOrAttribute
    }
  }
  
  var title: String
  var content: String
  var imageUrl: FeedURL
  var pubDate: String
  
  enum CodingKeys: String, CodingKey {
    case title
    case content = "description"
    case imageUrl = "enclosure"
    case pubDate
  }
  
  static func nodeDecoding(for key: CodingKey) -> XMLDecoder.NodeDecoding {
    switch key {
    case CodingKeys.imageUrl:
      return .element
    default:
      return .elementOrAttribute
    }
  }
}

struct Author: Decodable {
  var name: String
  var email: String
  var urlString: String
  
  enum CodingKeys: String, CodingKey {
    case name
    case email
    case urlString = "uri"
  }
}
