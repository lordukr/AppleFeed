//
//  Feed.swift
//  AppleFeed
//
//  Created by azavialov on 25.11.2020.
//

import Foundation

struct Feed: Decodable {
  var feedItems: [FeedItem]
  
  enum CodingKeys: String, CodingKey {
    case feedItems = "entry"
  }
}

struct FeedItem: Decodable {
  var title: String
  var content: String
  var author: Author
  
  enum CodingKeys: String, CodingKey {
    case title
    case content
    case author
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
