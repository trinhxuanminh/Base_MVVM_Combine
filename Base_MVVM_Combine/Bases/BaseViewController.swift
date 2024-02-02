//
//  BaseViewController.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import UIKit
import Combine

class BaseViewController: UIViewController, ViewProtocol {
  var subscriptions = Set<AnyCancellable>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    addComponents()
    setConstraints()
    setProperties()
    binding()
    DispatchQueue.main.async { [weak self] in
      guard let self else {
        return
      }
      setColor()
    }
  }
  
  deinit {
    removeSubs()
  }
  
  func addComponents() {}
  
  func setConstraints() {}
  
  func setProperties() {}
  
  func setColor() {}
  
  func binding() {}
  
  func removeSubs() {
    subscriptions.forEach { $0.cancel() }
    subscriptions.removeAll()
  }
}
