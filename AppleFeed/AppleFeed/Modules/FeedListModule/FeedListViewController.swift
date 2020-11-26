//
//  FeedListViewController.swift
//  AppleFeed
//
//  Created by azavialov on 26.11.2020.
//

import UIKit
import Combine

class FeedListViewController: UIViewController {
  private lazy var feedListView = FeedListView()
  
  let viewModel = FeedListViewModel()
  private var cancellable = Set<AnyCancellable>()
  
  override func loadView() {
    view = feedListView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .blue
    viewModel.$state
      .sink { (newState) in
        switch newState {
        case .failed(let error):
          print("error")
        case .idle:
          print("idle")
        case .loading:
          print("loading")
        case .loaded(let feed):
          print("loaded")
        }
      }.store(in: &cancellable)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel.input = .onViewControllerAppear
  }
}
