//
//  CardImageView.swift
//  Movies
//
//  Created by Jamile Bastos on 04/01/24.
//

import SwiftUI

struct MovieRow: View {
  @State var movie: Movie
  @EnvironmentObject var viewModel: MovieViewModel
  
  var body: some View {
    NavigationLink(destination: MovieDetailView(movie: movie)) {
      HStack {
        if let url = movie.posterURL {
          AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
              ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .red))
                .scaleEffect(2.0, anchor: .center)
                .frame(minWidth: 180, minHeight: 250)
            case .success(let image):
              image.resizable().cornerRadius(10)
            case .failure:
              Image(systemName: "photo").frame(minWidth: 180, minHeight: 250)
              
            @unknown default:
              fatalError("Unexpected case")
            }
          }
          .frame(width: 180, height: 250)
          .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.gray, lineWidth: 0.5))
        }
        VStack(alignment: .listRowSeparatorLeading, spacing: 5) {
          Text(movie.title)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.black)
          
          Text(movie.overview)
            .font(.subheadline)
            .multilineTextAlignment(.leading)
            .lineLimit(4, reservesSpace: true)
            .foregroundColor(.black)
            .truncationMode(.tail)
            .padding(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 0))
          
          Spacer()
          
          Button(action: {
            viewModel.toggleFavorite(movie: &movie)
          }) {
            Image(systemName: movie.isFavorite ? "heart.fill" : "heart")
          }
          
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .padding(.trailing, 10)
        .padding(.vertical, 5)
      }
      .frame(height: 250)
    }
  }
}
