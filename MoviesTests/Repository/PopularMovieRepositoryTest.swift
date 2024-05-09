//
//  MoviesRepositoryTests.swift
//  MoviesTests
//
//  Created by Jamile Bastos on 19/02/24.
//

import XCTest
@testable import Movies

class MockMovieService {
  static var shouldReturnError = false
  static var movies: MovieListResponse?
  
  static func fetchPopularMovies(page: Int) async throws -> MovieListResponse {
    if shouldReturnError {
      throw NSError(domain: "", code: -1, userInfo: nil)
    }
    return movies ?? MovieListResponse(results: [])
  }
}


class PopularMovieRepositoryTests: XCTestCase {
  var sut: MockPopularMovieRepository = MockPopularMovieRepository()
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testGetPopularMoviesSuccess() async throws {
    // Given
    let movie = APIMovie(id: 1, title: "Test", overview: "Test", poster_path: "", vote_average: 5.0)
    MockMovieService.movies = MovieListResponse(results: [movie])
    
    // When
    let result = await sut.getPopularMovies(page: 1)
    
    // Then
    switch result {
    case .success(let response):
      XCTAssertEqual(response.results.count, 1)
      XCTAssertEqual(response.results.first?.title, "Test")
    case .failure(_):
      XCTFail("Expected success, but got failure")
    }
  }
  
  func testGetPopularMoviesFailure() async throws {
    // Given
    MockMovieService.shouldReturnError = true
    
    // When
    let result = await sut.getPopularMovies(page: 1)
    
    // Then
    switch result {
    case .success(_):
      XCTFail("Expected failure, but got success")
    case .failure(let error):
      XCTAssertNotNil(error)
    }
  }
}
