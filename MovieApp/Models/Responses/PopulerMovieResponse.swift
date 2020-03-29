//
//  PopulerMovieResponse.swift
//  MovieApp
//
//  Created by Erkan CAN on 29.03.2020.
//  Copyright © 2020 Erkan CAN. All rights reserved.
//

import Foundation

// MARK: - PopulerMovieResponse
struct PopulerMovieResponse: Codable {
    let page, totalResults, totalPages: Int
    let results: [PopulerMovie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

