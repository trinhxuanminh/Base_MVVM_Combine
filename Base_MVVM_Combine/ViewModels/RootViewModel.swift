//
//  RootViewModel.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 05/02/2024.
//

import Foundation
import Combine

class RootViewModel: BaseViewModel {
  let listMovieViewModel: ListMovieViewModel
  
  override init() {
    self.listMovieViewModel = ListMovieViewModel(type: .nowPlaying)
    super.init()
  }
}
