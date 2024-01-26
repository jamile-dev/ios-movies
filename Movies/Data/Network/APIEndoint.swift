//
//  APIEndoint.swift
//  Movies
//
//  Created by Jamile Bastos on 09/12/23.
//

import Foundation
import SwiftUI

protocol APIEndpoint {
  var path: String { get }
  var queryItems: [URLQueryItem] { get }
}


extension APIEndpoint {
  
  var url: URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.themoviedb.org"
    components.path = path
    components.queryItems = queryItems + [
      URLQueryItem(name: "api_key", value: Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String),
    ]
    
    return components.url
  }
}
