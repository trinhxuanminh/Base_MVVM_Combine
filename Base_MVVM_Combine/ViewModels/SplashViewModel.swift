//
//  SplashViewModel.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 05/02/2024.
//

import Foundation
import Combine

class SplashViewModel: BaseViewModel {
  enum Action {
    case end
  }
  
  let action = PassthroughSubject<Action, Never>()
  private let router = SplashRouter()
  
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

extension SplashViewModel {
  private func processAction(_ action: Action) {
    switch action {
    case .end:
      if App.shared.allowShowWelcome {
        router.route(to: .welcome)
      } else {
        router.route(to: .root)
      }
      App.shared.didShowWelcome()
      App.shared.setShowAppOpen(allow: true)
    }
  }
}
