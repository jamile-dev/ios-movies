//
//  MovieViewModel.swift
//  Movies
//
//  Created by Jamile Bastos on 03/12/23.
//

import SwiftUI

@MainActor
class MovieListViewModel: ObservableObject {
  @Published var movies: [Movie] = []
  
  func fetchPopularMovies() async {
    do {
      let response = try await MovieService.fetchPopularMovies()
      self.movies = response.results
    } catch {
      print("Error fetching popular movies: \(error)")
    }
  }
}
