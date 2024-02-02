//
//  AppFont.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import UIKit

class AppFont {
  enum FontName: String {
    case familyRegular = ""
  }
  
  class func font(_ name: FontName, size: CGFloat) -> UIFont {
    guard let font = UIFont(name: name.rawValue, size: size) else {
      return UIFont.systemFont(ofSize: size)
    }
    return font
  }
}
