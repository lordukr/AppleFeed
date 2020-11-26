//
//  FeedListViewModel.swift
//  AppleFeed
//
//  Created by azavialov on 26.11.2020.
//

import Foundation
import Combine

final class FeedListViewModel: ObservableObject {
  @Published private(set) var state: State = .idle
  @Published var input = Event.initial
  
  private var bag = Set<AnyCancellable>()
  
  init() {
    $input.sink { [weak self] (event) in
      switch event {
      case .onViewControllerAppear:
        self?.loadFeed()
      default:
        break
      }
    }.store(in: &bag)
  }
}

extension FeedListViewModel {
  enum State {
    case idle
    case loading
    case loaded(Feed)
    case failed(Error)
  }
  
  enum Event {
    case initial
    case onViewControllerAppear
    case onItemSelected(IndexPath)
    case onFeedLoaded(Feed)
    case onFailedToLoadFeed(Error)
  }
}

extension FeedListViewModel {
//  static func reduce(state: State, event: Event) -> State {
//    switch state {
//    case .idle:
//      switch event {
//      case .onViewControllerAppear:
//        return .loading
//      case .onFeedLoaded(let feed):
//        return .loaded(feed)
//      case .onFailedToLoadFeed(let error):
//        return .failed(error)
//      default:
//        return state
//      }
//    case .loading:
//      switch event {
//      case .onFailedToLoadFeed(let error):
//        return .failed(error)
//      case .onFeedLoaded(let feed):
//        return .loaded(feed)
//      default:
//        return state
//      }
//    case .loaded, .failed:
//      return state
//    }
//  }
//
  func loadFeed() {
    FeedClient.getFeed()?
      .map(State.loaded)
      .catch { Just(State.failed($0)) }
      .eraseToAnyPublisher()
      .sink(receiveValue: { [weak self] (feed) in
        self?.state = feed
      })
      .store(in: &bag)
  }
}

