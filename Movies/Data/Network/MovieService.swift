//
//  MovieService.swift
//  Movies
//
//  Created by Jamile Bastos on 10/12/23.
//

import Foundation

struct MovieService {
  static func fetchPopularMovies() async throws -> MovieListResponse {
    let endpoint = MovieEndpoint.popular
    return try await APIClient.request(endpoint)
  }
}
