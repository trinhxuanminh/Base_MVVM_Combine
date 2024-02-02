//
//  CGFloatExtension.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import Foundation

extension CGFloat {
  // Làm tròn phần thập phân.
  func roundToDecimals(decimals: Int = 9) -> CGFloat {
    let multiplier = pow(10, CGFloat(decimals))
    return ((self * multiplier).rounded() / multiplier)
  }
}
