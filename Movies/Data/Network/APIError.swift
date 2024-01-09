//
//  NetworkError.swift
//  Movies
//
//  Created by Jamile Bastos on 08/12/23.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingError
}
