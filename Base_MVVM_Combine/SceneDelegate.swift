//
//  SceneDelegate.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import UIKit
import AdMobManager

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  
  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else {
      return
    }
    
    let window = UIWindow(windowScene: windowScene)
    
    let navigationController = UINavigationController(rootViewController: SplashVC())
    navigationController.isNavigationBarHidden = true
    
    window.rootViewController = navigationController
    self.window = window
    window.makeKeyAndVisible()
  }
  
  func sceneDidBecomeActive(_ scene: UIScene) {
    guard App.shared.allowShowAppOpen else {
      return
    }
    guard let topVC = UIApplication.topViewController() else {
      return
    }
    AdMobManager.shared.show(type: .appOpen,
                             name: AppText.AdName.appOpen,
                             rootViewController: topVC,
                             didFail: nil,
                             didHide: nil)
  }
}
