//
//  DateExtension.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import UIKit

extension Date {
  // Chuyển kiểu ngày thành chuỗi.
  func asString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    return dateFormatter.string(from: self)
  }
}
