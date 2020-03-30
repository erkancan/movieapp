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
    
    var tableviewCellsModelType : PublishSubject<[PopulerMovieListTableViewCellViewModelType]> { get set }

    
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
    var tableviewCellsModelType: PublishSubject<[PopulerMovieListTableViewCellViewModelType]>

    
    // MARK: Private
    private var service: ApiServices
    private var popularMovieCollections: Observable<[PopulerMovie]>!

    init(service: ApiServices) {
        
        self.service = service
        
        self.tableviewCellsModelType = PublishSubject()
        
        callNetworkRequest()
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
                let element =  response.results.compactMap { PopulerMovieListTableViewCellViewModel(populerMovie: $0) }
                self.tableviewCellsModelType.onNext(element)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
