//
//  FavoriteMovie.swift
//  Movies
//
//  Created by Jamile Bastos on 25/02/24.
//

import Foundation

struct FavoriteMovie: Identifiable {
  let id: Int
  let title: String
  let overview: String
  let poster_path: String?
  let vote_average: Float
}
