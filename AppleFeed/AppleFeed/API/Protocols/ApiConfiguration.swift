//
//  ApiConfiguration.swift
//  UsersListApp
//
//  Created by Anatolii Zavialov on 4/9/19.
//  Copyright © 2019 Anatolii Zavialov. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum EncodingError {
    case missingURL
    case jsonEncodingFailed(_ error: Error)
}

enum ApiError: Error {
    case parameterEncodingFailed(reason: EncodingError)
}

protocol APIConfiguration {
    var method: HTTPMethod { get }
    var path: String { get }
    var header: [String: String]? { get }
    var parameters: [String: AnyHashable]? { get }
    func asURLRequest() throws -> URLRequest
}

extension APIConfiguration {
    var header: [String: String]? { return nil }
}

extension APIConfiguration {
    func asURLRequest() throws -> URLRequest {
      var urlComps = URLComponents(string: API.kProductionServer.scheme + API.kProductionServer.baseURL + "/" + API.kProductionServer.api + path)
  
//        urlComps.scheme = API.kProductionServer.scheme
//      urlComps.host = API.kProductionServer.baseURL
//        urlComps.path = API.kProductionServer.api + path
        
      var urlRequest = URLRequest(url: (urlComps?.url)!)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if let header = header, let key = header.keys.first {
            urlRequest.setValue(header.values.first, forHTTPHeaderField: key)
        }
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw ApiError.parameterEncodingFailed(reason: .jsonEncodingFailed(error))
            }
        }
        
        return urlRequest
    }
}
