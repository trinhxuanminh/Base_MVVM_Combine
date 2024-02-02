//
//  UIApplicationExtension.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import UIKit

extension UIApplication {
  class func context() -> UINavigationController? {
    return UIApplication.shared.windows.first?.rootViewController as? UINavigationController
  }
  
  class func topViewController() -> UIViewController? {
    return context()?.topViewController
  }
}
