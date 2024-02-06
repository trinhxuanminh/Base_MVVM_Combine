//
//  ListMovieViewModel.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 05/02/2024.
//

import Foundation
import Combine

class ListMovieViewModel: BaseViewModel {
  enum State {
    case initial
    case fetched
  }
  
  enum Action {
    case loadMore
    case select(_ index: Int)
  }
  
  private let type: MovieType
  let action = PassthroughSubject<Action, Never>()
  let movies = CurrentValueSubject<[MovieViewModel], Never>([])
  let isLoading = CurrentValueSubject<Bool, Never>(false)
  private let state = CurrentValueSubject<State, Never>(.initial)
  private let useCase = ListMovieUseCase()
  private let router = ListMovieRouter()
  
  init(type: MovieType) {
    self.type = type
    super.init()
    
    // Subscriptions
    state.sink(receiveValue: { [weak self] state in
      guard let self else {
        return
      }
      processState(state)
    }).store(in: &subscriptions)
    
    action.sink(receiveValue: { [weak self] action in
      guard let self else {
        return
      }
      processAction(action)
    }).store(in: &subscriptions)
  }
}

extension ListMovieViewModel {
  private func processState(_ state: State) {
    switch state {
    case .initial:
      isLoading.value = true
      fetch()
    case .fetched:
      isLoading.value = false
    }
  }
  
  private func processAction(_ action: Action) {
    switch action {
    case .loadMore:
      fetch()
    case .select(let index):
      let movie = movies.value[index]
      router.route(to: .detail, parameters: [
        "movie": movie
      ])
    }
  }
}

extension ListMovieViewModel {
  private func fetch() {
    Task {
      let resultMovies = await useCase.getMovie(type: type)
      movies.value.append(contentsOf: resultMovies)
      state.value = .fetched
    }
  }
}
