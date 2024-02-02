//
//  RatingApp.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import UIKit

final class RatingApp {
  static let shared = RatingApp()
  
  enum Keys {
    static let didPushRate = "DID_PUSH_RATE"
  }
  
  private var didPushRate = false
}

extension RatingApp {
  func fetch() {
    self.didPushRate = UserDefaults.standard.bool(forKey: Keys.didPushRate)
  }
  
  func didRate() {
    self.didPushRate = true
    UserDefaults.standard.set(true, forKey: Keys.didPushRate)
  }
  
  func rateSetting() -> Bool {
    guard
      let pushRateConfig = App.shared.pushRateConfig,
      pushRateConfig.status,
      pushRateConfig.setting
    else {
      return false
    }
    return true
  }
  
  func ratingOnAppStore() {
    let reviewPath = "https://apps.apple.com/app/id\(AppText.App.idApp)?action=write-review"
    guard let writeReviewURL = reviewPath.getCleanedURL() else {
      return
    }
    UIApplication.shared.open(writeReviewURL,
                              options: [:],
                              completionHandler: nil)
  }
}
