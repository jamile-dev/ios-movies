//
//  CardImageView.swift
//  Movies
//
//  Created by Jamile Bastos on 04/01/24.
//

import SwiftUI

struct CardImageView: View {
  let movie: Movie
  
  var body: some View {
    NavigationLink(destination: MovieDetailView(movie: movie)) {
      VStack {
        if let url = movie.posterURL {
          AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
              ProgressView().frame(minWidth: 180, minHeight: 250)
            case .success(let image):
              image.resizable()
            case .failure:
              Image(systemName: "photo")
              
            @unknown default:
              fatalError("Unexpected case")
            }
          }
        }
      }
      .frame(height: 250)
      .overlay(RoundedRectangle(cornerRadius: 10)
        .stroke(Color.gray, lineWidth: 0.5))
    }
  }
}
