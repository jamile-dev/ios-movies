//
//  MovieViewModel.swift
//  Movies
//
//  Created by Jamile Bastos on 03/12/23.
//

import SwiftUI

class MovieListViewModel: ObservableObject {
  private let movieRepository: MovieRepository
  @Published var movies: [Movie] = []
  @Published var errorMessage: Error?
  @Published var isLoading: Bool = false
  
  init(movieRepository: MovieRepository = MovieRepositoryImpl()) {
    self.movieRepository = movieRepository
  }
  
  func fetchMovies() {
    Task {
      do {
        isLoading = true
        
        let result = try await movieRepository.getPopularMovies()
        
        switch result {
        case .success(let fetchedMovies):
          movies = fetchedMovies.results
        case .failure(let fetchError):
          errorMessage = fetchError
        case .loading: break
        }
        
        isLoading = false
      } catch {
        errorMessage = error
        isLoading = false
      }
    }
  }
}
