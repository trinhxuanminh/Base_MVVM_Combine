//
//  SplashVC.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 05/02/2024.
//

import UIKit
import AdMobManager

class SplashVC: BaseViewController {
  private let viewModel = SplashViewModel()
  private var firstAppear = true
  private var requestSplash = false
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .darkContent
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if !firstAppear {
      LoadingManager.shared.show(rootViewController: self)
    } else {
      self.firstAppear = false
    }
  }
  
  override func binding() {
    AdMobManager.shared.$state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self else {
          return
        }
        if state == .allow {
          if App.shared.openAppCount <= 1 {
            AdMobManager.shared.preloadNative(name: AppText.AdName.native)
          }
          AdMobManager.shared.load(type: .splash, name: AppText.AdName.splash)
          AdMobManager.shared.load(type: .appOpen, name: AppText.AdName.appOpen)
        }
        
        if state != .unknow, !requestSplash {
          self.requestSplash = true
          AdMobManager.shared.show(type: .splash,
                                   name: AppText.AdName.splash,
                                   rootViewController: self,
                                   didFail: self.endAnimation,
                                   didHide: self.endAnimation)
        }
      }.store(in: &subscriptions)
  }
}

extension SplashVC {
  private func endAnimation() {
    viewModel.action.send(.end)
  }
}
