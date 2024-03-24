//
//  FavoriteMovies.swift
//  Movies
//
//  Created by Jamile Bastos on 25/02/24.
//

import SwiftUI

struct FavoriteMovies: View {
  let movie: Movie
  var body: some View {
    MovieRow(movie: movie)
  }
}
