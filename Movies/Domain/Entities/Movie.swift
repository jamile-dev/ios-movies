//
//  MovieScreen.swift
//  Movies
//
//  Created by Jamile Bastos on 25/02/24.
//

import Foundation

struct Movie: Identifiable, Codable, Hashable {
  let id: Int
  let title: String
  let overview: String
  let vote_average: Float
  var posterURL: URL?
  var isFavorite: Bool
}
