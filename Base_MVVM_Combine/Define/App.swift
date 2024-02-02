//
//  App.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import Foundation
import FirebaseRemoteConfig
import AdMobManager
import IAPManager

final class App {
  static let shared = App()
  
  enum Keys {
    // Local
    static let didShowWelcome = "DID_SHOW_WELCOME"
    static let openAppCount = "OPEN_APP_COUNT"
    // Feedback
    static let email = "EMAIL"
    // IAA
    static let adMobConfig = "ADMOB_V1_0"
    // Push Rate
    static let pushRateConfig = "PUSH_RATE_V1_0"
    // Push Update
    static let pushUpdateConfig = "PUSH_UPDATE_V1_0"
  }
  
  // Local
  private(set) var loadRemoteConfigState = false
  private(set) var allowShowAppOpen = false
  private(set) var allowShowWelcome = false
  private(set) var openAppCount = 0
  // Feedback
  private(set) var email: String?
  // Push Rate
  private(set) var pushRateConfig: PushRateConfig?
  // Push Update
  private(set) var pushUpdateConfig: PushUpdateConfig?
}

extension App {
  func fetch() {
    fetchWelcome()
    
    AdMobManager.shared.addActionConfigValue { [weak self] remoteConfig in
      guard let self else {
        return
      }
      updateWithRCValues(remoteConfig: remoteConfig)
    }
    
    openApp()
    LanguageManager.shared.fetchChoseLanguage()
    RatingApp.shared.fetch()
    
    IAPManager.shared.verify(completion: { [weak self] permissions in
      guard let self else {
        return
      }
      PermissionManager.shared.unlock(permissions: permissions)
      registerAdMob()
    }, errored: registerAdMob)
  }
  
  func setShowAppOpen(allow: Bool) {
    self.allowShowAppOpen = allow
  }
  
  func didShowWelcome() {
    UserDefaults.standard.set(true, forKey: Keys.didShowWelcome)
    fetchWelcome()
  }
  
  func pushUpdate() -> Bool {
    guard
      let pushUpdateConfig,
      pushUpdateConfig.status,
      let versionString = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
      let version = Double(versionString),
      version < pushUpdateConfig.nowVersion
    else {
      return false
    }
    return true
  }
}

extension App {
  private func updateWithRCValues(remoteConfig: RemoteConfig) {
    // Feedback
    self.email = remoteConfig.configValue(forKey: Keys.email).stringValue
    // Push Rate
    let pushRateData = remoteConfig.configValue(forKey: Keys.pushRateConfig).dataValue
    if let pushRateConfig = try? JSONDecoder().decode(PushRateConfig.self, from: pushRateData) {
      self.pushRateConfig = pushRateConfig
    }
    // Push Update
    let pushUpdateData = remoteConfig.configValue(forKey: Keys.pushUpdateConfig).dataValue
    if let pushUpdateConfig = try? JSONDecoder().decode(PushUpdateConfig.self, from: pushUpdateData) {
      self.pushUpdateConfig = pushUpdateConfig
    }
    // Local
    self.loadRemoteConfigState = true
  }
  
  private func registerAdMob() {
//    AdMobManager.shared.activeDebug(testDeviceIdentifiers: ["F2BFBF3F-9B66-48E3-9C8A-CB15D388890A"],
//                                    reset: true)
    
    if let url = Bundle.main.url(forResource: "AdMobDefaultValue", withExtension: "json"),
       let data = try? Data(contentsOf: url) {
      AdMobManager.shared.register(remoteKey: Keys.adMobConfig, defaultData: data)
    }
  }
  
  private func fetchWelcome() {
    self.allowShowWelcome = !UserDefaults.standard.bool(forKey: Keys.didShowWelcome)
  }
  
  private func openApp() {
    self.openAppCount = UserDefaults.standard.integer(forKey: Keys.openAppCount)
    self.openAppCount += 1
    UserDefaults.standard.set(openAppCount, forKey: Keys.openAppCount)
  }
}
