//
//  MockRepository.swift
//  MoviesTests
//
//  Created by Jamile Bastos on 09/03/24.
//

import Foundation
@testable import Movies

class MockMovieRepository: MovieRepository {
  var popularMoviesResult: ResultType<MovieListResponse>?
  
  func getPopularMovies(page: Int) async throws -> ResultType<MovieListResponse> {
    guard let result = popularMoviesResult else {
      fatalError("popularMoviesResult not set")
    }
    return result
  }
}
