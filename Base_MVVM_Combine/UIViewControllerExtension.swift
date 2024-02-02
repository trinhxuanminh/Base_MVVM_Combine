//
//  UIViewControllerExtension.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import UIKit

extension UIViewController {
  class func loadFromNib() -> Self {
    func loadFromNib<T: UIViewController>(_ type: T.Type) -> T {
      return T.init(nibName: String(describing: T.self), bundle: nil)
    }
    return loadFromNib(self)
  }
}
