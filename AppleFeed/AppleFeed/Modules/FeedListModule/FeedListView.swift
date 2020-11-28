//
//  FeedListView.swift
//  AppleFeed
//
//  Created by azavialov on 26.11.2020.
//

import UIKit
import Combine
import SnapKit

enum FeedListViewState {
  case initial
  case loading
  case loaded
  case error
}

class FeedListView: UIView {
  @Published var state = FeedListViewState.initial
  
  private var bag = Set<AnyCancellable>()
  
  private(set) lazy var tableView = UITableView()
  private(set) lazy var errorLabel = UILabel()
  private(set) lazy var activityIndicator = UIActivityIndicatorView(style: .large)
  
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
  
  //MARK: - Bindings
  private func bind() {
    $state.sink { [weak self] (newState) in
      self?.errorLabel.isHidden = true
      self?.activityIndicator.stopAnimating()
      switch newState {
      case .initial:
        print("initial")
      case .loading:
        self?.activityIndicator.startAnimating()
        print("loading")
      case .loaded:
        self?.tableView.reloadData()
        print("loaded")
      case .error:
        self?.errorLabel.isHidden = false
        print("error")
      }
    }.store(in: &bag)
  }
  
  
  //MARK: - UI Setup
  private func setupUI() {
    setupTableView()
    setupErrorLabel()
    setupActivityIndicator()
  }
  
  private func setupTableView() {
    addSubview(tableView)
    
    tableView.estimatedRowHeight = UITableView.automaticDimension
    tableView.separatorInset = .zero
    tableView.separatorStyle = .none
    
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
  
  private func setupErrorLabel() {
    addSubview(errorLabel)
    
    errorLabel.isHidden = true
    errorLabel.text = "Failed to Load data"
    errorLabel.textAlignment = .center
    
    errorLabel.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
      make.leading.trailing.lessThanOrEqualTo(self)
    }
  }
  
  private func setupActivityIndicator() {
    addSubview(activityIndicator)
    
    activityIndicator.hidesWhenStopped = true
    
    activityIndicator.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
    }
  }
}
