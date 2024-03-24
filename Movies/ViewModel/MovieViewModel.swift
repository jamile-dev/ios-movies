//
//  MovieViewModel.swift
//  Movies
//
//  Created by Jamile Bastos on 03/12/23.
//

import SwiftUI

class MovieViewModel: ObservableObject {
  private let movieRepository: MovieRepository
  @Published var movies: [Movie] = []
  @Published var favoriteMovies: [Movie] = []
  @Published var errorMessage: Error?
  @Published private(set) var viewState: ViewState?
  private var currentPage: Int = 1
  var isLoading: Bool {
    viewState == .loading
  }
  
  var isFetching: Bool {
    viewState == .fetching
  }
  
  init(movieRepository: MovieRepository = MovieRepositoryImpl()) {
    self.movieRepository = movieRepository
  }
  
  @MainActor
  func fetchMovies() async {
    Task {
      do {
        viewState = .loading
        
        defer { viewState = .finished }
        
        let result = try await movieRepository.getPopularMovies(page: currentPage)
        
        switch result {
        case .success(let fetchedMovies):
          self.movies = fetchedMovies.results.map { movie in
            return APIMovie.fromAPIModel(apiModel: movie)
          }
        case .failure(let fetchError):
          errorMessage = fetchError
        case .loading: break
        }
        
      } catch {
        errorMessage = error
      }
    }
  }
  
  @MainActor
  func fetchNextSetOfMovies() async {
    viewState = .fetching
    defer { viewState = .finished }
    currentPage += 1
    
    do {
      let result = try await movieRepository.getPopularMovies(page: currentPage)
      
      switch result {
      case .success(let fetchedMovies):
        self.movies = fetchedMovies.results.map { movie in
          return APIMovie.fromAPIModel(apiModel: movie)
        }
      case .failure(let fetchError):
        errorMessage = fetchError
      case .loading: break
      }
      
    } catch {
      errorMessage = error
    }
  }
  
  func hasReachedEnd(of movie: Movie) -> Bool {
    movies.last?.id == movie.id
  }
  
  
  func toggleFavorite(movie: inout Movie) {
    if let index = favoriteMovies.firstIndex(where: { $0.id == movie.id }) {
      favoriteMovies.remove(at: index)
    } else {
      favoriteMovies.append(movie)
    }
    movie.isFavorite.toggle()
  }
  
}


extension MovieViewModel {
  enum ViewState {
    case fetching
    case loading
    case finished
  }
}
