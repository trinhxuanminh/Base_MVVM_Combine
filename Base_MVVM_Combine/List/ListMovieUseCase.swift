//
//  ListMovieUseCase.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 05/02/2024.
//

import Foundation

class ListMovieUseCase {
  private var page = 0
  private var totalPage = Int.max
  
  func getMovie(type: MovieType) async -> [MovieViewModel] {
    do {
      self.page += 1
      guard totalPage == Int.max || page <= totalPage else {
        return []
      }
      
      let endPoint: EndPoint
      switch type {
      case .nowPlaying:
        endPoint = .nowPlaying(page: page)
      }
      let movieResponse: MovieResponse = try await APIService().request(from: endPoint)
      self.page = movieResponse.page
      self.totalPage = movieResponse.totalPage
      return movieResponse.movies.map { movie in
        return MovieViewModel(movie: movie)
      }
    } catch let error {
      print(error)
      // Retry handler
      self.page -= 1
      let delaySecond = 5
      try? await Task.sleep(nanoseconds: UInt64(delaySecond) * 1_000_000_000)
      return await getMovie(type: type)
    }
  }
}
