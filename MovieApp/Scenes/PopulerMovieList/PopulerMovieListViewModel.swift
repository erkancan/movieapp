//
//  PopulerMovieListViewModel.swift
//  MovieApp
//
//  Created by Erkan CAN on 30.03.2020.
//  Copyright © 2020 Erkan CAN. All rights reserved.
//

import Foundation
import RxSwift

protocol PopularMovieListViewModelInput {
    
    

}

protocol PopulerMovieListViewModelOutput {

    //var homeViewCellModelTypes: Observable<[HomeViewCellModelType]> { get }
    
}

protocol PopulerMovieListViewModelType {
    var inputs: PopularMovieListViewModelInput { get }
    var outputs: PopulerMovieListViewModelOutput { get }
}



final class PopularMovieListViewModel: PopulerMovieListViewModelType, PopularMovieListViewModelInput, PopulerMovieListViewModelOutput {
    
    // MARK: Inputs & Outputs
    var inputs: PopularMovieListViewModelInput { return self }
    var outputs: PopulerMovieListViewModelOutput { return self }

    // MARK: Input


    // MARK: Output
  
//    let homeViewCellModelTypes: Observable<[HomeViewCellModelType]>
    
    // MARK: Private
    private var service: ApiServices
    private var populerMov: Observable<[PhotoCollection]>!

     
    init(service: ApiServices) {
        
        self.service = service
        
        callNetworkRequest()
        
    }
    
}

// MARK: - Network
extension PopularMovieListViewModel {
    
    
    func callNetworkRequest() {
        ApiRequest().callApi(PopulerMovieResponse.self, target: self.service) { (result) in
            
            switch result {
                case .success(let response):
                    
                    response.results.map { (<#PopulerMovie#>) -> T in
                        <#code#>
                }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
    }
}
