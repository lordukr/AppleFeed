//
//  FeedDetailsViewModel.swift
//  AppleFeed
//
//  Created by azavialov on 28.11.2020.
//

import Foundation

protocol FeedDetailsViewModelProtocol {
  var text: String { get set }
  var imageURL: String? { get set }
}

struct FeedDetailsViewModel: FeedDetailsViewModelProtocol {
  var imageURL: String?
  var text: String
  
  static func placeholder() -> FeedDetailsViewModel {
    return FeedDetailsViewModel(imageURL: "", text: "")
  }
}
