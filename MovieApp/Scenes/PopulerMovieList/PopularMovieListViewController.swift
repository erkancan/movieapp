//
//  PopulerMovieListViewController.swift
//  MovieApp
//
//  Created by Erkan CAN on 30.03.2020.
//  Copyright © 2020 Erkan CAN. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class PopularMovieListViewController: UIViewController, BindableType {
    
    
    typealias TablesSectionModel = SectionModel<String, PopulerMovieListTableViewCellViewModelType>
    
    //MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: Private
    let disposeBag = DisposeBag()
    private var dataSource: RxTableViewSectionedReloadDataSource<TablesSectionModel>!
    
    //MARK: ViewModel
    var viewModel: PopularMovieListViewModel!
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    //MARK: Methods
    func bindViewModel() {
        
        let output = viewModel.outputs
        
        output.tableviewCellsModelType
            .asObservable()
            .map {[TablesSectionModel(model: "", items: $0)]}
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected.bind { [weak self] (indexPath) in
            
            guard let self = self else {return}
            
            self.tableView.deselectRow(at: indexPath, animated: true)
            
            guard let cell = self.tableView.cellForRow(at: indexPath) as? PopulerMoviewListTableViewCell else { return}
            cell.viewModel.output.populerMovie.bind { [weak self] (movie) in
                
                guard let self = self else { return }
                self.openDetail(withPopulerMovie: movie)
                
            }.disposed(by: self.disposeBag)
            
        }.disposed(by: disposeBag)
        
        
    }
    
    func configureCollectionView() {
        tableView.register(cellType: PopulerMoviewListTableViewCell.self)
        
        dataSource = RxTableViewSectionedReloadDataSource<TablesSectionModel>(
            configureCell: tableViewDataSource
        )
    }
    
    
    private var tableViewDataSource: TableViewSectionedDataSource<TablesSectionModel>.ConfigureCell {
        return { _, tableView, indexPath, cellModel in
            var cell: PopulerMoviewListTableViewCell = self.tableView.dequeueResuableCell(forIndexPath: indexPath)
            cell.bind(to: cellModel)
            return cell
        }
    }
    
    func openDetail(withPopulerMovie movie: PopulerMovie)  {
        var controller = PopularMovieDetailViewController.initFromNib()
        controller.bind(to: PopularMovieDetailViewModel(movie: movie))
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
}
