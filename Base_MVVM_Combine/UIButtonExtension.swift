//
//  UIButtonExtension.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import UIKit

@IBDesignable extension UIButton {
  // Text sẽ được hiển thị theo ngôn ngữ với key này.
  @IBInspectable var localizeKey: String? {
    get {
      return self.titleLabel?.text
    } set {
      DispatchQueue.main.async {
        self.titleLabel?.text = newValue?.localized()
      }
    }
  }
}
