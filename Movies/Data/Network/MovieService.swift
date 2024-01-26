//
//  MovieService.swift
//  Movies
//
//  Created by Jamile Bastos on 10/12/23.
//

import Foundation

struct MovieService {
  static func fetchPopularMovies(page: Int) async throws -> MovieListResponse {
    let endpoint = MovieEndpoint.popular(page: page)
    return try await APIClient.request(endpoint)
  }
}
