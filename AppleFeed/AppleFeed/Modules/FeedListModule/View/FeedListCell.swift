//
//  FeedListCell.swift
//  AppleFeed
//
//  Created by azavialov on 28.11.2020.
//

import UIKit
import SnapKit
import Combine

class FeedListCell: UITableViewCell {
  @Published var viewModel = FeedListCellViewModel.placeholder()
  private var bag = Set<AnyCancellable>()
  
  private(set) lazy var titleLabel = UILabel()
  private(set) lazy var publishedDateLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
    bind()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
    bind()
  }
  
  private func bind() {
    $viewModel.sink { [weak self] (model) in
      self?.titleLabel.text = model.title
      self?.publishedDateLabel.text = model.pubDate
    }.store(in: &bag)
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
    titleLabel.numberOfLines = 2
    
    titleLabel.snp.makeConstraints { (make) in
      make.top.equalToSuperview().inset(5)
      make.leading.trailing.equalToSuperview().offset(10)
    }
  }
  
  private func setupAuthorLabel() {
    addSubview(publishedDateLabel)
    
    publishedDateLabel.font = UIFont.systemFont(ofSize: 12)
    publishedDateLabel.textColor = .black
    publishedDateLabel.lineBreakMode = .byTruncatingTail
    
    publishedDateLabel.snp.makeConstraints { (make) in
      make.top.equalTo(titleLabel.snp.bottom).offset(10)
      make.leading.trailing.bottom.equalToSuperview().inset(10)
    }
  }
}
