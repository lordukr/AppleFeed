//
//  FeedDetailsView.swift
//  AppleFeed
//
//  Created by azavialov on 28.11.2020.
//

import UIKit
import Combine
import Kingfisher

class FeedDetailsView: UIView {
  @Published var viewModel: FeedDetailsViewModelProtocol!
  private var bag = Set<AnyCancellable>()
  
  private(set) lazy var feedImageView = UIImageView()
  private(set) lazy var feedTextLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    bind()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
    bind()
  }
  
  convenience init(model: FeedDetailsViewModelProtocol) {
    self.init(frame: .zero)
    viewModel = model
  }
  
  private func bind() {
    $viewModel.sink { [weak self] (update) in
      if let imageURL = update?.imageURL, let url = URL(string: imageURL) {
        self?.feedImageView.kf.setImage(with: url, options: [.transition(.fade(0.3))])
      }
      self?.feedTextLabel.text = update?.text
    }.store(in: &bag)
  }
  
  private func setupUI() {
    backgroundColor = .white
    setupImageView()
    setupTextLabel()
  }
  
  private func setupImageView() {
    addSubview(feedImageView)
    
    feedImageView.contentMode = .scaleAspectFit
    
    feedImageView.snp.makeConstraints { (make) in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(feedImageView.snp.width)
    }
  }
  
  private func setupTextLabel() {
    addSubview(feedTextLabel)
    
    feedTextLabel.numberOfLines = 0
    
    feedTextLabel.snp.makeConstraints { (make) in
      make.top.equalTo(feedImageView.snp.bottom).offset(10)
      make.leading.trailing.equalToSuperview()
      make.bottom.lessThanOrEqualToSuperview()
    }
  }
}
