//
//  AppText.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import Foundation

class AppText {
  enum App {
    static let idApp = ""
    static let privacyLink = "https://nowtechpro.github.io/Privacy/Privacy.html"
    static let termsOfUse = "https://www.apple.com/legal/internet-services/itunes/dev/stdeula"
    static let email = "minhtx@proxglobal.com"
  }
  
  enum LanguageKeys: String {
    case language
    
    var localized: String? {
      return LanguageManager.localized(key: self.rawValue)
    }
  }
  
  enum AdName {
    static let appOpen = "App_Open"
    static let splash = "Splash"
    static let rewarded = "Rewarded"
    static let rewardedInterstitial = "Rewarded_Interstitial"
    static let interstitial1 = "Interstitial_1"
    static let interstitial2 = "Interstitial_2"
    static let native = "Native"
    static let banner1 = "Banner_1"
    static let banner2 = "Banner_2"
    static let banner3 = "Banner_3"
  }
}
