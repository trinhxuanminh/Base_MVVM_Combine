//
//  ListMovieUseCase.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 05/02/2024.
//

import Foundation

class ListMovieUseCase {
  func getMovie(type: MovieType) async -> [MovieViewModel] {
    do {
      let movieResponse: MovieResponse = try await APIService().request(from: .nowPlaying)
      return movieResponse.movies.map { movie in
        return MovieViewModel(movie: movie)
      }
    } catch {
      // Retry handler
      let delaySecond = 5
      try? await Task.sleep(nanoseconds: UInt64(delaySecond) * 1_000_000_000)
      return await getMovie(type: type)
    }
  }
}
