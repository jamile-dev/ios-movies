//
//  MovieDetailView.swift
//  Movies
//
//  Created by Jamile Bastos on 11/12/23.
//

import Foundation
import SwiftUI

struct MovieDetailView: View {
  let movie: Movie
  var body: some View {
    ZStack {
      Color.background.ignoresSafeArea()
      ScrollView {
        AsyncImage(url: movie.posterURL) { image in
          image.resizable().scaledToFit()
        } placeholder: {  
          ProgressView()
        }
        
        Text(movie.title)
          .font(.title)
          .padding()
        
        Text(movie.overview)
          .padding()
      }
    }
  }
}
