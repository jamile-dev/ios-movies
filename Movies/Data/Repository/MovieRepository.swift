//
//  MovieRepository.swift
//  Movies
//
//  Created by Jamile Bastos on 19/01/24.
//

import Foundation

protocol MovieRepository {
  func getPopularMovies(page: Int) async throws -> ResultType<MovieListResponse>
}

class MovieRepositoryImpl: MovieRepository {
  func getPopularMovies(page: Int) async -> ResultType<MovieListResponse> {
    do {
      let data = try await MovieService.fetchPopularMovies(page: page)
      return .success(data)
    } catch {
      return .failure(error)
    }
  }
}
