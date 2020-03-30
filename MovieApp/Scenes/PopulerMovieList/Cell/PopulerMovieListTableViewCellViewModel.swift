//
//  PopulerMoviewListTableViewModel.swift
//  MovieApp
//
//  Created by Erkan CAN on 30.03.2020.
//  Copyright © 2020 Erkan CAN. All rights reserved.
//

import Foundation
import RxSwift

protocol PopulerMovieListTableViewCellViewModelInput {}
protocol PopulerMovieListTableViewCellViewModelOutput {
    var populerMovie: Observable<PopulerMovie> { get }
}

protocol PopulerMovieListTableViewCellViewModelType {
    var input: PopulerMovieListTableViewCellViewModelInput { get }
    var output: PopulerMovieListTableViewCellViewModelOutput { get }
}

final class PopulerMovieListTableViewCellViewModel: PopulerMovieListTableViewCellViewModelType,
                                PopulerMovieListTableViewCellViewModelInput,
                                PopulerMovieListTableViewCellViewModelOutput {

    // MARK: Input & Output
    var input: PopulerMovieListTableViewCellViewModelInput { return self }
    var output: PopulerMovieListTableViewCellViewModelOutput { return self }

    // MARK: Input

    // MARK: Output
    let populerMovie: Observable<PopulerMovie>

    // MARK: Private

    // MARK: Init
 
    init(populerMovie: PopulerMovie) {
        self.populerMovie = Observable.just(populerMovie)
    }
}
