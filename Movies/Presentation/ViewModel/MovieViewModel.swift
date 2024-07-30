//
//  MovieViewModel.swift
//  Movies
//
//  Created by Jamile Bastos on 03/12/23.
//

import SwiftUI

class MovieViewModel: ObservableObject {
  private let favoriteMovieUseCase: FavoriteMovieUseCase
  private let popularMovieUseCase: PopularMovieUseCase
  
  let favoriteMovieRepository: FavoriteMovieRepositoryImpl = FavoriteMovieRepositoryImpl()
  let popularMovieRepository: PopularMovieRepositoryImpl = PopularMovieRepositoryImpl()

  var isLoadingNextPage = false
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
  
  init() {
    self.favoriteMovieUseCase = FavoriteMovieUseCase(repository: favoriteMovieRepository)
    self.popularMovieUseCase = PopularMovieUseCase(repository: popularMovieRepository)
    updateMovies()
    updateFavoriteMovies()
  }
  
  @MainActor
  func fetchMovies() async {
    Task {
      do {
        viewState = .loading
        
        defer { viewState = .finished }
        
        let result = await popularMovieUseCase.execute(page: currentPage)
        
        switch result {
        case .success(let fetchedMovies):
          self.movies = fetchedMovies.results.map { movie in
            return APIMovie.fromAPIModel(apiModel: movie)
          }
        case .failure(let fetchError):
          errorMessage = fetchError
        }
      }
    }
  }
  
  @MainActor
  func fetchNextSetOfMovies(for movie: Movie) async {
    guard !isLoadingNextPage else { return }
    guard hasReachedEnd(of: movie) else { return }
    
    isLoadingNextPage = true
    viewState = .fetching
    defer {
      isLoadingNextPage = false
      viewState = .finished
    }
    currentPage += 1
    
    do {
      let result = await popularMovieUseCase.execute(page: currentPage)
      switch result {
      case .success(let fetchedMovies):
        // TODO: refactor to repository
        self.movies += fetchedMovies.results.map { movie in
          return APIMovie.fromAPIModel(apiModel: movie)
        }
      case .failure(let fetchError):
        errorMessage = fetchError
      }
    }
  }
  
  func hasReachedEnd(of movie: Movie) -> Bool {
    guard let lastMovie = movies.last else { return false }
    return lastMovie.id == movie.id
  }
  
  func toggleFavorite(movie: Movie) {
    if isMovieFavorite(movie: movie) {
      favoriteMovieUseCase.executeRemoveFavoriteMovie(movie: movie)
    } else {
      favoriteMovieUseCase.executeAddFavoriteMovie(movie: movie)
    }
    updateFavoriteMovies()
  }
  
  func isMovieFavorite(movie: Movie) -> Bool {
    return favoriteMovieUseCase.isMovieFavorite(movie: movie)
  }
  
  private func updateFavoriteMovies() {
    favoriteMovies = favoriteMovieUseCase.getFavoriteMovies()
  }
  private func updateMovies() {
    let updatedMovies = movies.map { movie in
      var updatedMovie = movie
      updatedMovie.isFavorite = favoriteMovies.contains(movie)
      return updatedMovie
    }
    movies = updatedMovies
  }
}

extension MovieViewModel {
  enum ViewState {
    case fetching
    case loading
    case finished
  }
}
