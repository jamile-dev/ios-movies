//
//  MoviesMock.swift
//  MoviesTests
//
//  Created by Jamile Bastos on 29/01/24.
//

import Foundation
@testable import Movies

let movie1 = APIMovie(
    id: 1,
    title: "Inception",
    overview: "A thief who enters the dreams of others to steal their secrets.",
    poster_path: "/inception_poster.jpg",
    vote_average: 8.8
)

let movie2 = APIMovie(
    id: 2,
    title: "The Shawshank Redemption",
    overview: "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.",
    poster_path: "/shawshank_redemption_poster.jpg",
    vote_average: 9.3
)

let movie3 = APIMovie(
    id: 3,
    title: "The Dark Knight",
    overview: "A caped crusader takes on the Joker and brings hope to Gotham City.",
    poster_path: "/dark_knight_poster.jpg",
    vote_average: 9.0
)
