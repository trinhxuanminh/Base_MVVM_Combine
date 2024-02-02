//
//  StringExtension.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import UIKit

extension String {
  // Chuyển kiểu chuỗi thành ngày.
  func asDate() -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: self)
  }
  
  // Tính toán chiều cao cần thiết để hiển thị text.
  func heightText(width: CGFloat, font: UIFont) -> CGFloat {
    let maxSize = CGSize(width: width, height: CGFloat(MAXFLOAT))
    let text: String = self
    return text.boundingRect(with: maxSize,
                             options: .usesLineFragmentOrigin,
                             attributes: [.font: font],
                             context: nil).height + 1
  }
  
  // Tính toán chiều rộng cần thiết để hiển thị text.
  func widthText(height: CGFloat, font: UIFont) -> CGFloat {
    let maxSize = CGSize(width: CGFloat(MAXFLOAT), height: height)
    let text: String = self
    return text.boundingRect(with: maxSize,
                             options: .usesLineFragmentOrigin,
                             attributes: [.font: font],
                             context: nil).width + 1
  }
  
  // Chuyển đổi chuỗi thành URL sau khi loại bỏ các ký tự không hợp lệ.
  func getCleanedURL() -> URL? {
    guard !self.isEmpty else {
      return nil
    }
    if let url = URL(string: self) {
      return url
    } else if let urlEscapedString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
              let escapedURL = URL(string: urlEscapedString) {
      return escapedURL
    }
    return nil
  }
  
  // Xoá các khoảng trắng và xuống dòng.
  func trimmingAllSpaces(using characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
      return components(separatedBy: characterSet).joined()
  }
  
  // Trả về text bản địa hoá với key này.
  func localized() -> String {
    return LanguageManager.localized(key: self) ?? String()
  }
}
