//
//  UICollectionViewCellExtension.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import UIKit

extension UICollectionViewCell {
  // Lấy indexPath hiện tại của cell.
  func getIndexPath() -> IndexPath? {
    guard let collectionView = nearestAncestor(ofType: UICollectionView.self) else {
      return nil
    }
    return collectionView.indexPath(for: self)
  }
}
