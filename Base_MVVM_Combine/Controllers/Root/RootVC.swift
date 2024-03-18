//
//  RootVC.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 05/02/2024.
//

import UIKit
import AdMobManager

class RootVC: BaseViewController {
  private let viewModel = RootViewModel()
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .darkContent
  }
  
  override func binding() {
    AdMobManager.shared.$state
      .receive(on: DispatchQueue.main)
      .sink { state in
        if state == .allow {
          AdMobManager.shared.load(type: .appOpen, name: AppText.AdName.appOpen)
          AdMobManager.shared.load(type: .rewarded, name: AppText.AdName.rewarded)
          AdMobManager.shared.load(type: .rewardedInterstitial, name: AppText.AdName.rewardedInterstitial)
          AdMobManager.shared.load(type: .interstitial, name: AppText.AdName.interstitial1)
          AdMobManager.shared.load(type: .interstitial, name: AppText.AdName.interstitial2)
        }
      }.store(in: &subscriptions)
  }
}
