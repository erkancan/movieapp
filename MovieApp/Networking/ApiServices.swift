//
//  ApiServices.swift
//  Decuma
//
//  Created by Erkan CAN on 3.03.2019.
//  Copyright © 2019 Erkan CAN. All rights reserved.
//

import Moya

enum ApiServices {
    
    case getPopulerMovieList
    case getMovieDetail( movieID: String)

}


extension ApiServices: TargetType {
    
    var baseURL: URL {
        return URL(string: NetworkPath.endPoint)!
    }
    
    var path: String {
        
        switch self {
        case .getPopulerMovieList:
            return  "/movie/popular?api_key=d55ce90864fb84560a00d2b068350bf6&language=en-US&page=1"//NetworkPath.getPopulerMovieListPath
        case .getMovieDetail:
            return "/movie/popular?api_key=d55ce90864fb84560a00d2b068350bf6&language=en-US&page=1" //NetworkPath.getMovieDetailPath
        }
         
    }
    
    var method: Moya.Method {
        return Moya.Method.get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        default:
            return Task.requestPlain;
        }
        
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
        
    }
    
}
