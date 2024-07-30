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
        VStack {
          AsyncImage(url: movie.posterURL) { image in
            image.resizable().scaledToFit().frame(height: 400)
          } placeholder: {
            ProgressView()
          }
          
          Text(movie.title)
            .font(.title)
            .foregroundColor(.white)
            .lineLimit(2)
            .frame(maxWidth: .infinity)
            .padding(10)
          
          
          Text(movie.overview)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(10)
        }
      }
    }
  }
}
