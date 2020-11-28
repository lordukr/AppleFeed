//
//  FeedListCell.swift
//  AppleFeed
//
//  Created by azavialov on 28.11.2020.
//

import UIKit
import SnapKit

class FeedListCell: UITableViewCell {
  private(set) lazy var titleLabel = UILabel()
  private(set) lazy var authorLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
  }
  
  func update(item: FeedItem) {
    titleLabel.text = item.title
    authorLabel.text = item.pubDate
  }
  
  private func setupUI() {
    setupTitlelabel()
    setupAuthorLabel()
  }
  
  private func setupTitlelabel() {
    addSubview(titleLabel)
    
    titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
    titleLabel.textColor = .black
    titleLabel.lineBreakMode = .byTruncatingTail
    
    titleLabel.snp.makeConstraints { (make) in
      make.top.equalToSuperview().inset(5)
      make.leading.trailing.equalToSuperview().offset(10)
    }
  }
  
  private func setupAuthorLabel() {
    addSubview(authorLabel)
    
    authorLabel.font = UIFont.systemFont(ofSize: 12)
    authorLabel.textColor = .black
    authorLabel.lineBreakMode = .byTruncatingTail
    
    authorLabel.snp.makeConstraints { (make) in
      make.top.equalTo(titleLabel.snp.bottom).offset(10)
      make.leading.trailing.bottom.equalToSuperview().inset(10)
    }
  }
}
