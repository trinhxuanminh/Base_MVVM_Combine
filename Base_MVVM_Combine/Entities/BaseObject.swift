//
//  BaseObject.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import Foundation
import RealmSwift

class BaseObject: Object, Codable {
  @Persisted var id: String
  @Persisted var dataURL: String?
  @Persisted var filename: String?
  
  func isDownloaded() -> Bool {
    return filename != nil
  }
}
