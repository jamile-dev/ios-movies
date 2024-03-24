//
//  ContentView.swift
//  Movies
//
//  Created by Jamile Bastos on 09/11/23.
//

import SwiftUI

struct HomeScreen: View {
  @StateObject private var viewModel = MovieViewModel()
  
  var body: some View {
    TabView {
      NavigationView {
        ZStack {
          Color.background.ignoresSafeArea()
          if let error = viewModel.errorMessage {
            ErrorView(message: error.localizedDescription)
          } else if !viewModel.movies.isEmpty {
            ScrollView {
              LazyVStack(alignment: .leading, spacing: 10, pinnedViews: .sectionHeaders) {
                ForEach(viewModel.movies) { movie in
                  MovieRow(movie: movie).cornerRadius(10).padding(5)
                    .task {
                      if viewModel.hasReachedEnd(of: movie) && !viewModel.isFetching {
                        await viewModel.fetchNextSetOfMovies()
                      }
                    }
                }.overlay(RoundedRectangle(cornerRadius: 10)
                 .stroke(Color.gray, lineWidth: 0.5))
                 .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
              }
            }
          }
        }.task {
          await viewModel.fetchMovies()
        }
        .navigationTitle("Popular Movies 🍿")
      }.tabItem {
        Image(systemName: "list.dash")
        Text("All movies")
      }
      .environmentObject(viewModel)
      
      NavigationView {
        ZStack {
          Color.background.ignoresSafeArea()
          ScrollView {
            LazyVStack(alignment: .leading, spacing: 10) {
              ForEach(viewModel.favoriteMovies) { movie in
                MovieRow(movie: movie)
              }.overlay(RoundedRectangle(cornerRadius: 10)
               .stroke(Color.gray, lineWidth: 0.5))
               .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            }
          }
          .navigationTitle("Favorites 🎥")
        }
      }.tabItem {
        Image(systemName: "star.fill")
        Text("Favorites")
      }
      .environmentObject(viewModel)
    }
  }
}
