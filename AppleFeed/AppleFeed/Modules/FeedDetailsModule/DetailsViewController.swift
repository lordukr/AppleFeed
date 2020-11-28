//
//  DetailsVIewController.swift
//  AppleFeed
//
//  Created by azavialov on 28.11.2020.
//

import UIKit
import Combine

class DetailsViewController: UIViewController {
  @Published var viewModel: FeedDetailsViewModelProtocol!
  private var bag = Set<AnyCancellable>()
  
  private var feedDetailsView: FeedDetailsView
  
  override func loadView() {
    view = feedDetailsView
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    feedDetailsView = FeedDetailsView()
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    bind()
  }
  
  required init?(coder: NSCoder) {
    feedDetailsView = FeedDetailsView()
    super.init(coder: coder)
    bind()
  }
  
  private func bind() {
    $viewModel.sink { [weak self] (model) in
      self?.title = model?.text
      self?.feedDetailsView.viewModel = model
    }.store(in: &bag)
  }
}
