//
//  FavoriteMovieRepository.swift
//  Movies
//
//  Created by Jamile Bastos on 11/06/24.
//

import Foundation

protocol FavoriteMovieRepository {
  func addFavoriteMovie(movie: Movie)
  
  func removeFavoriteMovie(movie: Movie)
  
  func getFavorites() -> [Movie]
}
