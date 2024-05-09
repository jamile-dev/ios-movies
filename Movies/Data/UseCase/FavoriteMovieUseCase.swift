//
//  FavoriteMovieUseCase.swift
//  Movies
//
//  Created by Jamile Bastos on 28/03/24.
//

import Foundation

class FavoriteMovieUseCase {
  let repository: FavoriteMovieRepository
  
  
  init(repository: FavoriteMovieRepository) {
    self.repository = repository
  }
  
  
  
  func executeAddFavoriteMovie(movie: Movie) {
    repository.addFavoriteMovie(movie: movie)
  }
  
  func executeRemoveFavoriteMovie(movie: Movie) {
    repository.removeFavoriteMovie(movie: movie)
  }
  
  func getFavoriteMovies() -> [Movie] {
    return repository.getFavorites()
  }
  
  func isMovieFavorite(movie: Movie) -> Bool {
    let favorites = getFavoriteMovies()
    return favorites.contains(movie)
  }
}
