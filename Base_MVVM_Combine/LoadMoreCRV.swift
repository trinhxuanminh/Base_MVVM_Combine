//
//  LoadMoreCRV.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 06/02/2024.
//

import UIKit
import NVActivityIndicatorView

class LoadMoreCRV: UICollectionReusableView {
  @IBOutlet weak var loadingView: NVActivityIndicatorView!
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    loadingView.startAnimating()
  }
  
  override func removeFromSuperview() {
    loadingView.stopAnimating()
    super.removeFromSuperview()
  }
}
