//
//  ContentView.swift
//  Movies
//
//  Created by Jamile Bastos on 09/11/23.
//

import SwiftUI

struct MovieListView: View {
  @StateObject private var viewModel = MovieListViewModel()
  
  var body: some View {
    NavigationView {
      ScrollView {
        LazyVGrid(columns: [
          GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
            ForEach(viewModel.movies) { movie in
              VStack(alignment: .leading) {
                CardImageView(movie: movie).cornerRadius(10)
                Text(movie.title)
                  .font(.caption)
                  .lineLimit(1)
                  .bold()
                  .padding(.top, 4)
              }
            }
          }
          .padding(10)
          .onAppear {
            Task {
              await viewModel.fetchPopularMovies()
            }
          }
      }.padding(10)
      .navigationTitle("Popular Movies 🍿")
    }
  }
}

#Preview {
  MovieListView()
}
