//
//  ApiRequest.swift
//  
//
//  Created by ERKAN CAN on 25.05.2019.
//  Copyright © 2019 ERKAN CAN. All rights reserved.
//

import Foundation
import Moya
import RxSwift


final class ApiRequest: ApiRouter {
    
    func callApi<T: Codable>(_ responseType: T.Type, target: ApiServices, completion: @escaping CompletionHandler<T>) where T: Decodable {
       
        CallApi(target, apiResponse: responseType.self) { (response) in
            
            completion(response)
            
        }
    }
    
}
