//
//  MovieViewModelTests.swift
//  MoviesTests
//
//  Created by Jamile Bastos on 06/01/24.
//

import XCTest
@testable import Movies

class MovieViewModelTests: XCTestCase {
  
  var mockRepository: MockMovieRepository!
  var viewModel: MovieViewModel!
  
  override func setUp() {
    super.setUp()
    mockRepository = MockMovieRepository()
    viewModel = MovieViewModel(movieRepository: mockRepository)
  }
  
  func testFetchMoviesSuccess() async throws {
    // Arrange
    let apiMovie1 = APIMovie(id: 1, title: "Mock Movie 1", overview: "Mock Overview 1", poster_path: nil, vote_average: 8.0)
    let apiMovie2 = APIMovie(id: 2, title: "Mock Movie 2", overview: "Mock Overview 2", poster_path: nil, vote_average: 7.5)
    let movieListResponse = MovieListResponse(results: [apiMovie1, apiMovie2])
    mockRepository.popularMoviesResult = .success(movieListResponse)

    // Act
    await viewModel.fetchMovies()
    
    sleep(5)
    
    // Assert
    XCTAssertEqual(viewModel.movies.count, 2)
    XCTAssertEqual(viewModel.movies[1].title, "Mock Movie 2")
    XCTAssertNil(viewModel.errorMessage)
  }
  
  func testFetchNextSetOfMoviesSuccess() async throws {
    // Arrange
    let apiMovie1 = APIMovie(id: 1, title: "Mock Movie 1", overview: "Mock Overview 1", poster_path: nil, vote_average: 8.0)
    let apiMovie2 = APIMovie(id: 2, title: "Mock Movie 2", overview: "Mock Overview 2", poster_path: nil, vote_average: 7.5)
    let apiMovie3 = APIMovie(id: 3, title: "Mock Movie 3", overview: "Mock Overview 3", poster_path: nil, vote_average: 7.5)
    let movieListResponse = MovieListResponse(results: [apiMovie1, apiMovie2, apiMovie3])
    mockRepository.popularMoviesResult = .success(movieListResponse)
        
    // Act
    await viewModel.fetchNextSetOfMovies()
    
    // Assert
    XCTAssertEqual(viewModel.movies.count, 3)
    XCTAssertEqual(viewModel.movies[0].title, "Mock Movie 1")
    XCTAssertEqual(viewModel.movies[2].title, "Mock Movie 3")
    XCTAssertNil(viewModel.errorMessage)
  }
  
  func testFetchMoviesFailure() async throws {
    // Arrange
    let expectedError = NSError(domain: "TestError", code: 123, userInfo: nil)
    mockRepository.popularMoviesResult = .failure(expectedError)
    
    // Act
    await viewModel.fetchMovies()
    
    sleep(5)
    
    // Assert
    XCTAssertNotNil(viewModel.errorMessage)
    XCTAssertEqual(viewModel.errorMessage?.localizedDescription, expectedError.localizedDescription)
    XCTAssertEqual(viewModel.movies.count, 0)
  }
  
}
