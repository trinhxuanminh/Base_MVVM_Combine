//
//  UILableExtension.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import UIKit

@IBDesignable extension UILabel {
  @IBInspectable var localizeKey: String? {
    get {
      return self.text
    } set {
      DispatchQueue.main.async {
        self.text = newValue?.localized()
      }
    }
  }
}
