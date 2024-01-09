//
//  MovieEndpoint.swift
//  Movies
//
//  Created by Jamile Bastos on 10/12/23.
//

import Foundation

enum MovieEndpoint: APIEndpoint {
  case popular
  
  var path: String {
    switch self {
    case .popular:
      return "/3/movie/popular"
    }
  }
  
  var queryItems: [URLQueryItem] {
    return []
  }
}
