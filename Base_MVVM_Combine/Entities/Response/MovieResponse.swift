//
//  MovieResponse.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 05/02/2024.
//

import Foundation

struct MovieResponse: Codable {
  let page: Int
  let totalPage: Int
  let movies: [MovieObject]
  
  enum CodingKeys: String, CodingKey {
    case page
    case totalPage = "total_pages"
    case movies = "results"
  }
}
