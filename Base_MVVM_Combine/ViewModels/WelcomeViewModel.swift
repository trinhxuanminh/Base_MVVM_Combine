//
//  WelcomeViewModel.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 05/02/2024.
//

import Foundation
import Combine

class WelcomeViewModel: BaseViewModel {
  enum Action {
    case skip
  }
  
  let action = PassthroughSubject<Action, Never>()
  private let router = WelcomeRouter()
  
  override init() {
    super.init()
    
    // Subscriptions
    action.sink(receiveValue: { [weak self] action in
      guard let self else {
        return
      }
      processAction(action)
    }).store(in: &subscriptions)
  }
}

extension WelcomeViewModel {
  private func processAction(_ action: Action) {
    switch action {
    case .skip:
      router.route(to: .root)
    }
  }
}
