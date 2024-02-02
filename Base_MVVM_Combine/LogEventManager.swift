//
//  LogEventManager.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import Foundation
import FirebaseAnalytics

class LogEventManager {
  static let shared = LogEventManager()
  
  func log(event: Event) {
    Analytics.logEvent(event.name, parameters: event.parameters)
  }
}

enum Event {
  case openApp
  
  var name: String {
    switch self {
    case .openApp:
      return "Open_App"
    }
  }
  
  var parameters: [String: Any]? {
    switch self {
    case .openApp:
      return [AnalyticsParameterContent: "Open đầu tiên"]
    }
  }
}
