//
//  PushUpdateConfig.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import Foundation

struct PushUpdateConfig: Codable {
  let status: Bool
  let nowVersion: Double
  let obligatory: Bool
  let content: String
}
