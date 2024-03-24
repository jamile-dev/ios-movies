//
//  Movie.swift
//  Movies
//
//  Created by Jamile Bastos on 01/12/23.
//

import Foundation

struct APIMovie: Identifiable, Decodable, Equatable {
  let id: Int
  let title: String
  let overview: String
  let poster_path: String?
  let vote_average: Float
  
  var posterURL: URL? {
    if poster_path != nil {
      return URL(string: "https://image.tmdb.org/t/p/w500" + poster_path!)
    }
    return nil
  }
  
  static func fromAPIModel(apiModel: APIMovie) -> Movie {
    return Movie(id: apiModel.id, title: apiModel.title, overview: apiModel.overview, vote_average: apiModel.vote_average, posterURL: apiModel.posterURL, isFavorite: false)
  }
  
}

struct MovieListResponse: Decodable {
  let results: [APIMovie]
}
