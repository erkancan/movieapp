//
//  PopulerMoviewListTableViewCell.swift
//  MovieApp
//
//  Created by Erkan CAN on 30.03.2020.
//  Copyright © 2020 Erkan CAN. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class PopulerMoviewListTableViewCell: UITableViewCell, BindableType, NibIdentifiable & ClassIdentifiable  {
    
    //MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    
    // MARK: ViewModel
    var viewModel: PopulerMovieListTableViewCellViewModelType!
    
    
    //MARK: Private
    private var disposeBag = DisposeBag()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func bindViewModel() {
        let output = viewModel.output
        
        output.populerMovie
            .map({$0.name ?? ""})
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.populerMovie
        .map({$0.originalLanguage ?? ""})
        .bind(to: originalLanguageLabel.rx.text)
        .disposed(by: disposeBag)
        
    }
    
    
}
