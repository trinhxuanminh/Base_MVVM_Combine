//
//  BaseViewModel.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import Foundation
import Combine

class BaseViewModel {
  var subscriptions = Set<AnyCancellable>()
  
  deinit {
    removeSubs()
  }
  
  func removeSubs() {
    subscriptions.forEach { $0.cancel() }
    subscriptions.removeAll()
  }
}
