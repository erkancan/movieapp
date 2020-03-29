//
//  ApiError.swift
//  MovieApp
//
//  Created by Erkan CAN on 28.03.2020.
//  Copyright © 2020 Erkan CAN. All rights reserved.
//

import Foundation

enum APIError: Error {
    case unknown
    case decodingError(Error)
    case noJSONData
    case errorMessage(String)
    case internalServer
    //TODO: can add more cases
}
