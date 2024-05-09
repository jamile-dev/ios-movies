//
//  MockRepository.swift
//  MoviesTests
//
//  Created by Jamile Bastos on 09/03/24.
//

import Foundation
@testable import Movies

class MockPopularMovieRepository: PopularMovieRepository {
  var popularMoviesResult: ResultType<MovieListResponse>?
  
  override func getPopularMovies(page: Int) async -> ResultType<MovieListResponse> {
    guard let result = popularMoviesResult else {
      fatalError("popularMoviesResult not set")
    }
    return result
  }
}


// Mock UserDefaults for testing purposes
class MockUserDefaults: UserDefaults {
    var storage: [String: Any] = [:]  
    
    override func set(_ value: Any?, forKey defaultName: String) {
        storage[defaultName] = value
    }
    
    override func data(forKey defaultName: String) -> Data? {
        return storage[defaultName] as? Data
    }
}

// Mock FavoriteMovieRepository for testing purposes
class MockFavoriteMovieRepository: FavoriteMovieRepository {
    var mockUserDefaults = MockUserDefaults()
    
    override func getFavorites() -> [Movie] {
        guard let data = mockUserDefaults.data(forKey: "favorite") else { return [] }
        let decoder = JSONDecoder()
        return (try? decoder.decode([Movie].self, from: data)) ?? []
    }
}
