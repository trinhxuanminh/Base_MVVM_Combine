//
//  PermissionManager.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import Foundation
import Combine
import IAPManager
import Glassfy
import AdMobManager

class PermissionManager {
  static let shared = PermissionManager()
  
  enum SKUId {
    static let weekly = "weekly"
    static let monthly = "monthly"
    static let yearly = "yearly"
  }
  
  @Published private(set) var isPremium = false
}

extension PermissionManager {
  func unlock(permissions: [Glassfy.Permission]) {
    for permission in permissions {
      switch permission.permissionId {
      case "premium":
        self.isPremium = true
        AdMobManager.shared.upgradePremium()
      default:
        print("Permission not handled")
      }
    }
  }
  
  func consumable(sku: Glassfy.Sku) {
    switch sku.skuId {
    default:
      print("Sku not handled")
    }
  }
}
