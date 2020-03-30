//
//  ApiRouter.swift
//  
//
//  Created by ERKAN CAN on 28/11/2017.
//  Copyright © 2017 ERKAN CAN. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import RxSwift
import RxMoya

typealias CompletionHandler<T: Decodable> = (APIResponse<T>) -> ()

class ApiRouter {
    
    var requests: [Cancellable] = []
    
    private var header = ["Accept": "application/json",
                          "language": "tr_TR",
                          "Content-Type": "application/json",
                          "api_key": NetworkPath.apiKey
    ]
    
    private func createEndPoint<T: TargetType>(_ target: T) -> Endpoint {
        
        return Endpoint(
            url: "\(target.baseURL)\(target.path)",
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
        
    }
    
    private var provider = MoyaProvider<ApiServices>()
    
    func CallApi< T: Codable >(_ target: ApiServices, apiResponse: T.Type, completion: @escaping CompletionHandler<T>) where T: Decodable {
        
        
        let defaultEndpoint = createEndPoint(target)
        
        let endpointClosure = { [weak self] (target: ApiServices) -> Endpoint in
            
            return defaultEndpoint.adding(newHTTPHeaderFields:(self?.header)!)
            
        }
        
        let plugins: [PluginType] = [NetworkLoggerPlugin()]
        
        let closure = endpointClosure
        
        provider = MoyaProvider<ApiServices>(endpointClosure: closure, plugins: plugins)
        
        _ = provider.rx
            .request(target, callbackQueue: DispatchQueue.main)
            .asObservable().debug().subscribe({ (event) in
                
                if let response = event.element?.response {
                    
                    if 200 ..< 300 ~= response.statusCode {
                        
                        guard let data = event.element?.data else {
                            
                            completion(.failure(.unknown))
                            return
                        }
                        
                        do {
                            
                            let baseResponse = try JSONDecoder().decode(T.self, from: data)
                            
                            completion(.success(baseResponse))
                            
                        } catch let error {
                            
                            debugPrint(error.localizedDescription)
                            
                            completion(.failure(.decodingError(error)))
                        }
                        
                    } else if 400 ..< 500 ~= response.statusCode {
                        
                        completion(.failure(.internalServer))
                    }
                    
                }
                
            })
        
    }
}
