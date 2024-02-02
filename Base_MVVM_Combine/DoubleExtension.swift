//
//  DoubleExtension.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import Foundation

extension Double {
  // Làm tròn phần thập phân.
  func roundToDecimals(decimals: Int = 9) -> Double {
    let multiplier = pow(10, Double(decimals))
    return ((self * multiplier).rounded() / multiplier)
  }
  
  // Trả về giá trị bình phương.
  func square() -> Double {
    return self * self
  }
}
