//
//  ContentView.swift
//  Movies
//
//  Created by Jamile Bastos on 09/11/23.
//

import SwiftUI

struct HomeScreen: View {
  @ObservedObject private var viewModel = MovieViewModel()
  
  var body: some View {
    NavigationView {
      VStack {
        if viewModel.isLoading {
          LoadingView()
        } else if let error = viewModel.errorMessage {
          ErrorView(message: error.localizedDescription)
        } else if !viewModel.movies.isEmpty {
          ScrollView {
            LazyVGrid(columns: [
              GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(viewModel.movies) { movie in
                  VStack(alignment: .leading) {
                    CardImageView(movie: movie).cornerRadius(10)
                      .task {
                        if viewModel.hasReachedEnd(of: movie) && !viewModel.isFetching {
                          await viewModel.fetchNextSetOfMovies()
                        }
                      }
                    Text(movie.title)
                      .font(.caption)
                      .lineLimit(1)
                      .bold()
                      .padding(.top, 4)
                  }
                }
              }
              .padding(10)
          }.padding(10)
          
        }
      }
      .navigationTitle("Popular Movies 🍿")
    }
    .task {
      await viewModel.fetchMovies()
    }
  }
}
