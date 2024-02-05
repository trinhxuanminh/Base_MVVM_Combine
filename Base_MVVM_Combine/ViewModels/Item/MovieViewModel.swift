//
//  MovieViewModel.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 05/02/2024.
//

import UIKit
import Combine
import SDWebImage

class MovieViewModel: BaseViewModel {
  enum State {
    case initial
  }
  
  let movie: MovieObject
  let backdrop = CurrentValueSubject<UIImage?, Never>(AppImage.image(.normal))
  let poster = CurrentValueSubject<UIImage?, Never>(AppImage.image(.normal))
  let title = CurrentValueSubject<String?, Never>(nil)
  let overview = CurrentValueSubject<String?, Never>(nil)
  let genres = CurrentValueSubject<String?, Never>(nil)
  let vote = CurrentValueSubject<String?, Never>(nil)
  private let state = CurrentValueSubject<State, Never>(.initial)
  
  init(movie: MovieObject) {
    self.movie = movie
    super.init()
    
    // Subscriptions
    state.sink(receiveValue: { [weak self] state in
      guard let self else {
        return
      }
      processState(state)
    }).store(in: &subscriptions)
  }
}

extension MovieViewModel {
  private func processState(_ state: State) {
    switch state {
    case .initial:
      title.value = movie.title
      overview.value = movie.overview
      vote.value = String(movie.vote.roundToDecimals(decimals: 1)) + " Star"
      genres.value = "Action"
      bindBackdrop()
      bindPoster()
    }
  }
}

extension MovieViewModel {
  private func bindBackdrop() {
    guard let url = (URLs.image + movie.backdrop).getCleanedURL() else {
      return
    }
    SDWebImageManager.shared.loadImage(with: url,
                                       progress: nil,
                                       completed: { [weak self] image, _, _, _, _, _ in
      guard let self, let image else {
        return
      }
      backdrop.value = image
    })
  }
  
  private func bindPoster() {
    guard let url = (URLs.image + movie.poster).getCleanedURL() else {
      return
    }
    SDWebImageManager.shared.loadImage(with: url,
                                       progress: nil,
                                       completed: { [weak self] image, _, _, _, _, _ in
      guard let self, let image else {
        return
      }
      poster.value = image
    })
  }
}
