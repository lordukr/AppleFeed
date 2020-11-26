//
//  ApiClient.swift
//  AppleFeed
//
//  Created by azavialov on 25.11.2020.
//

import Foundation
import Alamofire
import Combine

struct ApiClient {
  func performRequest<T: Decodable>(route: APIConfiguration, queue: DispatchQueue = .main, decoder: DataDecoder = JSONDecoder()) -> AnyPublisher<T, AFError>? {
    guard let urlRequest = try? route.asURLRequest() else {
      return Empty().eraseToAnyPublisher()
    }
    return AF.request(urlRequest)
        .publishDecodable(type: T.self, queue: queue, decoder: decoder)
        .value()
        .eraseToAnyPublisher()
  }
}
