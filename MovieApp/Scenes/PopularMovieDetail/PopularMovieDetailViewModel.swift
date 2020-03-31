//
//  PopularMovieDetailViewModel.swift
//  MovieApp
//
//  Created by Erkan CAN on 31.03.2020.
//  Copyright © 2020 Erkan CAN. All rights reserved.
//

import Foundation
import RxSwift

protocol PopularMovieDetailViewModelInput {
    var populerMovie: PopulerMovie { get set }

}

protocol PopularMovieDetailViewModelOutput {
    
    var detailMovie: Observable<PopulerMovie> { get }
 
}

protocol PopularMovieDetailViewModelType {
    var inputs: PopularMovieDetailViewModelInput { get }
    var outputs: PopularMovieDetailViewModelOutput { get }
}



final class PopularMovieDetailViewModel: PopularMovieDetailViewModelType, PopularMovieDetailViewModelInput, PopularMovieDetailViewModelOutput {
      
    // MARK: Inputs & Outputs
    var inputs: PopularMovieDetailViewModelInput { return self }
    var outputs: PopularMovieDetailViewModelOutput { return self }
   
    
    // MARK: Input
    var populerMovie: PopulerMovie

    // MARK: Output
    lazy var detailMovie: Observable<PopulerMovie> = {
        return .just(self.populerMovie)
    }()


    init(movie: PopulerMovie) {
        self.populerMovie = movie

    }
    
}
 
