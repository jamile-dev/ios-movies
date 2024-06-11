//
//  PopularMovieRepository.swift
//  Movies
//
//  Created by Jamile Bastos on 11/06/24.
//

import Foundation

protocol PopularMovieRepository {
  func getPopularMovies(page: Int) async -> ResultType<MovieListResponse>
}
