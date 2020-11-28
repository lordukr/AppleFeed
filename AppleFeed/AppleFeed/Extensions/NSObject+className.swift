//
//  UITableVIewCell+className.swift
//  AppleFeed
//
//  Created by azavialov on 28.11.2020.
//

import Foundation

extension NSObject {
  class var className: String {
    String(describing: self)
  }
}
