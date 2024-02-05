//
//  MovieObject.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 05/02/2024.
//

import Foundation
import RealmSwift

class MovieObject: BaseObject {
  @Persisted var backdrop: String
  @Persisted var poster: String
  @Persisted var title: String
  @Persisted var overview: String
  @Persisted var vote: Double
  @Persisted var genres: List<Int>
  
  enum CodingKeys: String, CodingKey {
    case id
    case backdrop = "backdrop_path"
    case poster = "poster_path"
    case title
    case overview
    case vote = "vote_average"
    case genres = "genre_ids"
  }
  
  required convenience init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = String(try container.decode(Int.self, forKey: .id))
    self.backdrop = try container.decode(String.self, forKey: .backdrop)
    self.poster = try container.decode(String.self, forKey: .poster)
    self.title = try container.decode(String.self, forKey: .title)
    self.overview = try container.decode(String.self, forKey: .overview)
    self.vote = try container.decode(Double.self, forKey: .vote)
    
    if let genres = try container.decode([Int]?.self, forKey: .genres) {
      self.genres.append(objectsIn: genres)
    }
  }
}
