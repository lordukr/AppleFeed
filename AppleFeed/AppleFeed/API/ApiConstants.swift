//
//  ApiConstants.swift
//  UsersListApp
//
//  Created by Anatolii Zavialov on 4/10/19.
//  Copyright © 2019 Anatolii Zavialov. All rights reserved.
//

import Foundation

struct API {
    struct kProductionServer {
        static let scheme = "https://"
        static let baseURL = "nshipster.com/"
        static let api = ""
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
