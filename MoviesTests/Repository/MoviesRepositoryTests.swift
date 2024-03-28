//
//  MoviesRepositoryTests.swift
//  MoviesTests
//
//  Created by Jamile Bastos on 19/02/24.
//

import XCTest
@testable import Movies


class MovieRepositoryTests: XCTestCase {
  
  var movieRepository: MovieRepository!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    movieRepository = MovieRepositoryImpl()
  }
  
  override func tearDownWithError() throws {
    movieRepository = nil
    try super.tearDownWithError()
  }
  
  func testGetPopularMoviesSuccess() async throws {
    // Arrange
    let expectedMoviesCount = 20
    let page = 1
    
    // Act
    let result = try await movieRepository.getPopularMovies(page: page)
    
    // Assert
    switch result {
    case .success(let response):
      XCTAssertEqual(response.results.count, expectedMoviesCount)
    default:
      XCTFail("Success Result")
    }
  }
  
  func testGetPopularMoviesFailure() async throws {
    // Arrange
    let page = -1 // Invalid number to return an error
    
    // Act
    let result = try await movieRepository.getPopularMovies(page: page)
    
    // Assert
    switch result {
    case .failure(let error):
      XCTAssertNotNil(error)
    default:
      XCTFail("Error \(result)")
    }
  }
  
  func testGetPopularMoviesEmptyList() async throws {
    // Arrange
    let page = 1000000000000000 // Large number to return an empty list
    
    // Act
    let result = try await movieRepository.getPopularMovies(page: page)
    
    // Assert
    switch result {
    case .success(let response):
      XCTAssertTrue(response.results.isEmpty)
    default:
      print(result)
    }
  }
}
