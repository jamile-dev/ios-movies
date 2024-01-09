//
//  Movie.swift
//  Movies
//
//  Created by Jamile Bastos on 01/12/23.
//

import Foundation

struct Movie: Identifiable, Decodable {
  let id: Int
  let title: String
  let overview: String
  let poster_path: String?  
  
  var posterURL: URL? {
    if poster_path != nil {
      return URL(string: "https://image.tmdb.org/t/p/w500" + poster_path!)
    }
    return nil
  }
}

struct MovieListResponse: Decodable {
  let results: [Movie]
}
