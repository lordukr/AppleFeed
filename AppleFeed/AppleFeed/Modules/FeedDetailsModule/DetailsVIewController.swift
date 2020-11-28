//
//  DetailsVIewController.swift
//  AppleFeed
//
//  Created by azavialov on 28.11.2020.
//

import UIKit

class DetailsVIewController: UIViewController {
  private var feedDetailsView: FeedDetailsView
  
  override func loadView() {
    view = feedDetailsView
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    feedDetailsView = FeedDetailsView()
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    feedDetailsView = FeedDetailsView()
    super.init(coder: coder)
  }
}
