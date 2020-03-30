//
//  PopulerMovieListViewModel.swift
//  MovieApp
//
//  Created by Erkan CAN on 30.03.2020.
//  Copyright © 2020 Erkan CAN. All rights reserved.
//

import Foundation
import RxSwift

protocol PopularMovieListViewModelInput {}

protocol PopulerMovieListViewModelOutput {
    
    //var homeViewCellModelTypes: Observable<[HomeViewCellModelType]> { get }
    
    var tableviewCellsModelType: Observable<[PopulerMovieListTableViewCellViewModelType]> { get }

    
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
    
    var tableviewCellsModelType: Observable<[PopulerMovieListTableViewCellViewModelType]>

    
    // MARK: Private
    private var service: ApiServices
    private var popularMovieCollections: Observable<[PopulerMovie]>!

    init(service: ApiServices) {
        
        self.service = service
        
        self.tableviewCellsModelType = Observable.just([PopulerMovieListTableViewCellViewModel]())
    }
    
}

// MARK: - Network
extension PopularMovieListViewModel {
    
    
    func callNetworkRequest() {
        
        ApiRequest().callApi(PopulerMovieResponse.self, target: self.service) { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                 
                self.popularMovieCollections = Observable.just(response.results)
                self.tableviewCellsModelType = self.popularMovieCollections.mapMany { PopulerMovieListTableViewCellViewModel(populerMovie: $0) }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
