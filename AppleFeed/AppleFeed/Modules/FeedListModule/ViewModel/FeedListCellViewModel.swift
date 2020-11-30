//
//  FeedListCellViewModel.swift
//  AppleFeed
//
//  Created by azavialov on 30.11.2020.
//

import Foundation

struct FeedListCellViewModel {
  let title: String
  let pubDate: String
  
  static func placeholder() -> Self {
    return FeedListCellViewModel(title: "", pubDate: "")
  }
  
  init(title: String, pubDate: String) {
    self.title = title
    self.pubDate = pubDate
  }
  
  init(_ domainModel: FeedItemDomainModel) {
    self.title = domainModel.title
    self.pubDate = domainModel.pubDate
  }
}
