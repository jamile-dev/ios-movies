//
//  PopularMovieUseCase.swift
//  Movies
//
//  Created by Jamile Bastos on 28/03/24.
//

import Foundation

class PopularMovieUseCase {
  let repository: PopularMovieRepository
  
  init(repository: PopularMovieRepositoryImpl) {
    self.repository = repository
  }
  
  func execute(page: Int) async -> ResultType<MovieListResponse>  {
    await repository.getPopularMovies(page: page)
  }
}
