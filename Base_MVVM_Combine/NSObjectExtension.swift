//
//  NSObjectExtension.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import Foundation

extension NSObject {
  public class var className: String {
    return String(describing: self)
  }
  
  public var className: String {
    return String(describing: self)
  }
}
