//
//  Router.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import UIKit

protocol Router {
  associatedtype RouteType: RawRepresentable where RouteType.RawValue: StringProtocol
  
  func route(to route: RouteType, parameters: [String: Any]?)
}

extension Router {
  func context() -> UINavigationController? {
    return UIApplication.shared.windows.first?.rootViewController as? UINavigationController
  }
}
