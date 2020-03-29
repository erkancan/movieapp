//
//  ApiResponse.swift
//  MovieApp
//
//  Created by Erkan CAN on 28.03.2020.
//  Copyright © 2020 Erkan CAN. All rights reserved.
//

import Foundation

enum APIResponse<T: Decodable> {
    case success(T)
    case failure(APIError)
}


