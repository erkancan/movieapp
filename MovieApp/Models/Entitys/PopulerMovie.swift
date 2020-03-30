//
//  PopulerMovie.swift
//  MovieApp
//
//  Created by Erkan CAN on 29.03.2020.
//  Copyright © 2020 Erkan CAN. All rights reserved.
//

import Foundation

// MARK: - PopulerMovie
struct PopulerMovie: Codable {
    let originalName: String?
    let genreIDS: [Int]?
    let title: String?
    let popularity: Double?
    let originCountry: [String]?
    let voteCount: Int?
    let firstAirDate, backdropPath, originalLanguage: String?
    let id: Int?
    let voteAverage: Double?
    let overview, posterPath: String?

    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case genreIDS = "genre_ids"
        case title, popularity
        case originCountry = "origin_country"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case id
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
    }
}
