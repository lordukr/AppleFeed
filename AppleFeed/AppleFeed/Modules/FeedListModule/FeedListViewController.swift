//
//  FeedListViewController.swift
//  AppleFeed
//
//  Created by azavialov on 26.11.2020.
//

import UIKit
import Combine

class FeedListViewController: UIViewController {
  private var feedListView: FeedListView
  fileprivate let controller: FeedListController
  
  let viewModel = FeedListViewModel()
  private var cancellable = Set<AnyCancellable>()
  
  override func loadView() {
    view = feedListView
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    feedListView = FeedListView()
    controller = FeedListController(tableView: feedListView.tableView)
    
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    feedListView = FeedListView()
    controller = FeedListController(tableView: feedListView.tableView)
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "RSS Feed"
    
    controller.delegate = self
    
    viewModel.$state
      .sink { [weak self] (newState) in
        switch newState {
        case .failed(let error):
          print("error:\(error)")
          self?.feedListView.state = .error
        case .idle:
          break
        case .loading:
          self?.feedListView.state = .loading
        case .loaded(let feed):
          self?.controller.updateWith(feed: feed)
        }
      }.store(in: &cancellable)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel.sendEvent(event: .onViewControllerAppear)
  }
}

extension FeedListViewController: FeedListControllerDelegate {
  func didSelectCell(with item: FeedItem) {
    
    let model = FeedDetailsViewModel(imageURL: item.imageUrl.url, text: item.content)
    
    let detailsVC = DetailsViewController()
    detailsVC.viewModel = model
    
    navigationController?.pushViewController(detailsVC, animated: true)
  }
  
  func didUpdateDataSource() {
    feedListView.state = .loaded
  }
}
