//
//  RootVC.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 05/02/2024.
//

import UIKit
import AdMobManager
import NVActivityIndicatorView

class RootVC: BaseViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var loadingView: NVActivityIndicatorView!
  
  enum Section: CaseIterable {
    case movies
  }
  
  private let viewModel = RootViewModel()
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .darkContent
  }
  
  override func setProperties() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.registerNib(ofType: MovieCVC.self)
    collectionView.registerNib(ofType: LoadMoreCRV.self, ofKind: .footer)
  }
  
  override func binding() {
    AdMobManager.shared.$state
      .receive(on: DispatchQueue.main)
      .sink { state in
        if state == .allow {
          AdMobManager.shared.load(type: .appOpen, name: AppText.AdName.appOpen)
          AdMobManager.shared.load(type: .rewarded, name: AppText.AdName.rewarded)
          AdMobManager.shared.load(type: .rewardedInterstitial, name: AppText.AdName.rewardedInterstitial)
          AdMobManager.shared.load(type: .interstitial, name: AppText.AdName.interstitial1)
          AdMobManager.shared.load(type: .interstitial, name: AppText.AdName.interstitial2)
        }
      }.store(in: &subscriptions)
    
    viewModel.listMovieViewModel.movies
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        guard let self else {
          return
        }
        collectionView.reloadData()
      }.store(in: &subscriptions)
    
    viewModel.listMovieViewModel.isLoading
      .receive(on: DispatchQueue.main)
      .sink { [weak self] isLoading in
        guard let self else {
          return
        }
        collectionView.isHidden = isLoading
        loadingView.isHidden = !isLoading
        if isLoading {
          loadingView.startAnimating()
        } else {
          loadingView.stopAnimating()
        }
      }.store(in: &subscriptions)
  }
}

extension RootVC: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel.listMovieViewModel.action.send(.select(indexPath.item))
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      willDisplaySupplementaryView view: UICollectionReusableView,
                      forElementKind elementKind: String,
                      at indexPath: IndexPath) {
    guard elementKind == UICollectionView.Kind.footer.value else {
      return
    }
    viewModel.listMovieViewModel.action.send(.loadMore)
  }
}

extension RootVC: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return Section.allCases.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch Section.allCases[section] {
    case .movies:
      return viewModel.listMovieViewModel.movies.value.count
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch Section.allCases[indexPath.section] {
    case .movies:
      let cell = collectionView.dequeue(ofType: MovieCVC.self, indexPath: indexPath)
      cell.setViewModel(viewModel.listMovieViewModel.movies.value[indexPath.item])
      return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath
  ) -> UICollectionReusableView {
    return collectionView.dequeue(ofType: LoadMoreCRV.self, ofKind: .footer, indexPath: indexPath)
  }
}

extension RootVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    switch Section.allCases[indexPath.section] {
    case .movies:
      let sumInset = 24.0 * 2
      let groupSpace = 16.0
      let numberGroupOnPhone = 2.0
      let scale = 156.0 / 240.0
      let width: CGFloat!
      if UIDevice.current.userInterfaceIdiom == .phone {
        width = (collectionView.frame.width - sumInset - (numberGroupOnPhone - 1) * groupSpace) / numberGroupOnPhone
        - AppSize.divisionInterval
      } else {
        let minWidth = AppSize.normalPhoneWidth / numberGroupOnPhone
        let maxItemInGroupOnPad = CGFloat(Int((collectionView.frame.width - sumInset + groupSpace) / (minWidth + groupSpace)))
        width = (collectionView.frame.width - sumInset - (maxItemInGroupOnPad - 1) * groupSpace) / maxItemInGroupOnPad
        - AppSize.divisionInterval
      }
      return CGSize(width: width, height: width / scale)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    switch Section.allCases[section] {
    case .movies:
      return UIEdgeInsets(top: 8.0,
                          left: 24.0,
                          bottom: 16.0,
                          right: 24.0)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    switch Section.allCases[section] {
    case .movies:
      return 16.0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    switch Section.allCases[section] {
    case .movies:
      return 16.0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForFooterInSection section: Int
  ) -> CGSize {
    switch Section.allCases[section] {
    case .movies:
      return CGSize(width: collectionView.frame.width, height: 50.0)
    }
  }
}
