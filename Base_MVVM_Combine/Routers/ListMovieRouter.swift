//
//  ListMovieRouter.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 05/02/2024.
//

import UIKit
import AdMobManager

class ListMovieRouter: Router {
  typealias RouteType = Route
  
  enum Route: String {
    case detail
  }
}

extension ListMovieRouter {
  func route(to route: Route, parameters: [String: Any]? = nil) {
    guard let context = context() else {
      return
    }
    
    switch route {
    case .detail:
      guard
        let parameters,
        let movie = parameters["movie"] as? MovieObject
      else {
        return
      }
      // Handler show detail
      print(context, movie)
    }
  }
}
