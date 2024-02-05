//
//  WelcomeVC.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 05/02/2024.
//

import UIKit

class WelcomeVC: BaseViewController {
  private let viewModel = WelcomeViewModel()
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .darkContent
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: { [weak self] in
      guard let self else {
        return
      }
      viewModel.action.send(.skip)
    })
  }
}
