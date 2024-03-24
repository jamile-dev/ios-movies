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
    ScrollView {
      HStack {
        MovieRow(movie: movie).cornerRadius(10).padding(5)
      }
    }
  }
}
