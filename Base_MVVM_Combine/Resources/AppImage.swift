//
//  AppImage.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import UIKit

class AppImage {
  enum Image {
    case normal
  }
  
  static func image(_ name: Image) -> UIImage {
    if let image = UIImage(named: "\(name)") {
      return image
    } else if let imageSystem = UIImage(systemName: "\(name)") {
      return imageSystem
    }
    return image(Image.normal)
  }
}
