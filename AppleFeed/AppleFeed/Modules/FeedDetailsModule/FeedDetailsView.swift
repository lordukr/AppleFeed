//
//  FeedDetailsView.swift
//  AppleFeed
//
//  Created by azavialov on 28.11.2020.
//

import UIKit

class FeedDetailsView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
  }
  
  private func setupUI() {
    backgroundColor = .blue
  }
}
