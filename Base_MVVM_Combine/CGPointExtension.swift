//
//  CGPointExtension.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import Foundation

extension CGPoint {
  // Trả về khoảng cách giữa 2 điểm.
  func distance(to second: CGPoint) -> Double {
    let first = self
    return sqrt((second.x - first.x).square() + (second.y - first.y).square())
  }
}
