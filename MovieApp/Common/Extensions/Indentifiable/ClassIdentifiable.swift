//
//  ClassIdentifiable.swift
//
//
//  Created by ERKAN CAN on 28/11/2017.
//  Copyright © 2017 ERKAN CAN. All rights reserved.
//
import UIKit

protocol ClassIdentifiable: class {
    static var reuseId: String { get }
}

extension ClassIdentifiable {
    static var reuseId: String {
        return String(describing: self)
    }
}
