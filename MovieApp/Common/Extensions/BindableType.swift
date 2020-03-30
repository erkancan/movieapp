//
//  BindableType.swift
//  MovieApp
//
//  Created by Erkan CAN on 30.03.2020.
//  Copyright © 2020 Erkan CAN. All rights reserved.
//

import UIKit

/**
 
 Each view controller conforming to the BindableType protocol
 will declare a viewModel variable and provide a bindViewModel() function
 to be called once the viewModel variable is assigned.
 This function will connect UI elements to observables and actions in the view model.
 
 */

protocol BindableType {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    mutating func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        bindViewModel()
    }
    
}

extension BindableType where Self: UIView {
    mutating func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        bindViewModel()
    }
}
