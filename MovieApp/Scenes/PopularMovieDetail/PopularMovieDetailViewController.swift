//
//  PopularMovieDetailViewController.swift
//  MovieApp
//
//  Created by Erkan CAN on 31.03.2020.
//  Copyright © 2020 Erkan CAN. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class PopularMovieDetailViewController: UIViewController, BindableType {

    
    //MARK: IBOutlet
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    //MARK: ViewModel
    var viewModel: PopularMovieDetailViewModel!
    
    let disbag = DisposeBag()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    func bindViewModel() {
        
        let output = viewModel.outputs

        output.detailMovie
            .map({$0.title ?? ""})
            .bind(to: titleLabel.rx.text)
            .disposed(by: disbag)
        
        output.detailMovie
            .map({$0.overview ?? ""})
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disbag)
        
        output.detailMovie.bind { [weak self] (movie) in
            
            guard let self = self else { return }
            
            if let url = URL(string: "\(NetworkPath.imageEndPoint)\(movie.posterPath ?? "")") {
                self.posterImageView.kf.setImage(with: url)
            }
            
            
        }.disposed(by: disbag)
         
    }

}
