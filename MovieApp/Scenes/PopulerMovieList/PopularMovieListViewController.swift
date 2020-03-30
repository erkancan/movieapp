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
        //
        //        viewModel.outputs.tableviewCellsModelType
        //            .map { [TablesSectionModel(model: "", items: $0)] }
        //            .bind(to: tableView.rx.items(dataSource: dataSource))
        //            .disposed(by: disposeBag)
        
        
        
        output.tableviewCellsModelType
            .asObservable()
            .map {[TablesSectionModel(model: "", items: $0)]}
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
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
    
    
}
