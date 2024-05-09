//
//  MovieViewModelTests.swift
//  MoviesTests
//
//  Created by Jamile Bastos on 06/01/24.
//

import XCTest
@testable import Movies

class MockFavoriteMovieUseCase: FavoriteMovieUseCase {
  var movies: [Movie] = []
  
  override func executeAddFavoriteMovie(movie: Movie) {
    movies.append(movie)
  }
  
  override func executeRemoveFavoriteMovie(movie: Movie) {
    movies.removeAll { $0.id == movie.id }
  }
  
  override func getFavoriteMovies() -> [Movie] {
    return movies
  }
  
  override func isMovieFavorite(movie: Movie) -> Bool {
    return movies.contains(movie)
  }
}

class MockPopularMovieUseCase: PopularMovieUseCase {
  var movies: [APIMovie] = []
  
  override func execute(page: Int) async -> ResultType<MovieListResponse> {
    return .success(MovieListResponse(results: movies))
  }
}

class MovieViewModelTests: XCTestCase {
  var sut: MovieViewModel!
  var favoriteUseCase: MockFavoriteMovieUseCase!
  var popularUseCase: MockPopularMovieUseCase!
  
  override func setUp() {
    super.setUp()
    favoriteUseCase = MockFavoriteMovieUseCase(repository: MockFavoriteMovieRepository() )
    popularUseCase = MockPopularMovieUseCase(repository: MockPopularMovieRepository())
    sut = MovieViewModel()
  }
  
  override func tearDown() {
    sut = nil
    favoriteUseCase = nil
    popularUseCase = nil
    super.tearDown()
  }
  
  func testFetchMovies() async throws {
    // Given
    let movie = APIMovie(id: 0, title: "Test", overview: "Test", poster_path: "nil", vote_average: 5.0)
    popularUseCase.movies = [movie]
    
    // When
    let expectation = XCTestExpectation(description: "Fetching movies")
    Task {
      await sut.fetchMovies()
      
      // Then
      DispatchQueue.main.async {
        XCTAssertEqual(self.sut.movies.count, 1)
        XCTAssertEqual(self.sut.movies.first?.title, "Test")
        expectation.fulfill()
      }
    }
    
    await fulfillment(of: [expectation], timeout: 1.0)
  }
  
  func testToggleFavorite() async throws {
    // Given
    let movie = Movie(id: 1, title: "Test", overview: "Test", vote_average: 5.0, posterURL: nil, isFavorite: false)
    
    // When
    sut.toggleFavorite(movie: movie)
    
    // Then
    XCTAssertTrue(sut.isMovieFavorite(movie: movie))
    
    // When
    sut.toggleFavorite(movie: movie)
    
    // Then
    XCTAssertFalse(sut.isMovieFavorite(movie: movie))
  }
}
