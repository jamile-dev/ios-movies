//
//  FavoriteMovieRepository.swift
//  Movies
//
//  Created by Jamile Bastos on 08/04/24.
//

import Foundation

class FavoriteMovieRepositoryImpl: FavoriteMovieRepository {
  func addFavoriteMovie(movie: Movie) {
    var favorites = getFavorites()
    favorites.append(movie)
    saveFavorites(favorites: favorites)
  }
  
  func removeFavoriteMovie(movie: Movie) {
    var favorites = getFavorites()
    if let index = favorites.firstIndex(of: movie) {
      favorites.remove(at: index)
      saveFavorites(favorites: favorites)
    }
  }
  
  func getFavorites() -> [Movie] {
    guard let data = UserDefaults.standard.data(forKey: "favorite") else { return [] }
    let decoder = JSONDecoder()
    return (try? decoder.decode([Movie].self, from: data)) ?? []
  }
  
  private func saveFavorites(favorites: [Movie]) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(favorites) {
      UserDefaults.standard.set(encoded, forKey: "favorite")
    }
  }
}
