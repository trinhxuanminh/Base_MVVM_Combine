//
//  LanguageManager.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import Foundation

class LanguageManager {
  static let shared = LanguageManager()
  
  enum Keys {
    static let choseLanguage = "CHOSE_LANGUAGE"
  }
  
  private var choseLanguage: Language = .english
  
  func getChoseLanguage() -> Language {
    return choseLanguage
  }
  
  func setChoseLanguage(_ newValue: Language) {
    self.choseLanguage = newValue
    UserDefaults.standard.set(newValue.rawValue, forKey: Keys.choseLanguage)
  }
  
  func fetchChoseLanguage() {
    self.choseLanguage = Language(rawValue: UserDefaults.standard.integer(forKey: Keys.choseLanguage)) ?? .english
  }
  
  class func localized(key: String) -> String? {
    guard let bundlePath = Bundle.main.path(forResource: shared.choseLanguage.code, ofType: "lproj") else {
      return nil
    }
    guard let bundle = Bundle(path: bundlePath) else {
      return nil
    }
    return NSLocalizedString(key, bundle: bundle, comment: String())
  }
}
