//
//  FeedListController.swift
//  AppleFeed
//
//  Created by azavialov on 28.11.2020.
//

import UIKit

protocol FeedListControllerDelegate: class {
  func didSelectCell(with item: FeedItem)
  func didUpdateDataSource()
}

class FeedListController: NSObject {
  let tableView: UITableView!
  
  private var numberOfItems: Int {
    items.count
  }
  
  private var items: [FeedItem] = []
  
  weak var delegate: FeedListControllerDelegate?
  
  init(tableView: UITableView) {
    self.tableView = tableView
    tableView.register(FeedListCell.self, forCellReuseIdentifier: FeedListCell.className)
    super.init()
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  func updateWith(feed: Feed) {
    items = feed.feedItems
    delegate?.didUpdateDataSource()
  }
}

extension FeedListController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numberOfItems
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedListCell.className, for: indexPath) as? FeedListCell else {
      return UITableViewCell()
    }
    
    let item = items[indexPath.item]
    
    cell.update(item: item)
    
    return cell
  }
}

extension FeedListController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let item = items[indexPath.item]
    
    delegate?.didSelectCell(with: item)
  }
}
