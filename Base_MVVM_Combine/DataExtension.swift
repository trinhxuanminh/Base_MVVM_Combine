//
//  DataExtension.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import Foundation

extension Data {
  // Chuyển đổi chuỗi thành dữ liệu, dùng để thêm body khi đẩy data lên server.
  mutating func append(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
