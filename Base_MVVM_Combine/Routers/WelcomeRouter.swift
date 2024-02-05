//
//  WelcomeRouter.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 05/02/2024.
//

import UIKit

class WelcomeRouter: Router {
  typealias RouteType = Route
  
  enum Route: String {
    case root
  }
}

extension WelcomeRouter {
  func route(to route: Route, parameters: [String: Any]? = nil) {
    guard let context = context() else {
      return
    }
    
    switch route {
    case .root:
      context.remake(maxLength: 0, to: RootVC())
    }
  }
}
