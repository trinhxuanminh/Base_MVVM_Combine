//
//  UINavigationControllerExtension.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import UIKit

extension UINavigationController {
  func push(to viewController: UIViewController, animated: Bool = false) {
    pushViewController(viewController, animated: animated)
  }
  
  func present(to viewController: UIViewController, animated: Bool = false) {
    present(viewController, animated: animated, completion: nil)
  }
  
  func pop(index: Int, animated: Bool = false) {
    guard index <= viewControllers.count - 1 else {
      return
    }
    let viewController = viewControllers[index]
    popToViewController(viewController, animated: animated)
  }
  
  func pop(animated: Bool = false) {
    popViewController(animated: animated)
  }
  
  func dismiss(animated: Bool = false) {
    dismiss(animated: animated, completion: nil)
  }
  
  func remake(maxLength: Int, to viewController: UIViewController) {
    let belowControllers = viewControllers.prefix(maxLength)
    viewControllers = belowControllers + [viewController]
  }
  
  func root(viewController: UIViewController) {
    viewControllers = [viewController]
  }
}
