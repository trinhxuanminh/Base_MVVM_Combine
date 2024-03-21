//
//  AppDelegate.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import UIKit
import Firebase
import IAPManager

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Override point for customization after application launch.
    FirebaseApp.configure()
//    TrackingSDK.shared.initialize(devKey: <#T##String#>,
//                                  appID: AppText.App.idApp,
//                                  timeout: nil)
//    IAPManager.shared.initialize(apiKey: <#T##String#>)
    App.shared.fetch()
    return true
  }
}
