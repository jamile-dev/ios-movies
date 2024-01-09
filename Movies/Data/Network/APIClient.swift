//
//  APIClient.swift
//  Movies
//
//  Created by Jamile Bastos on 01/12/23.
//

import Foundation

struct APIClient {
  static func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
    guard let url = endpoint.url else {
      throw APIError.invalidURL
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode(T.self, from: data)
  }
}
