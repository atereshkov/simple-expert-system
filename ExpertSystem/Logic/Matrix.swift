//
//  Matrix.swift
//  ExpertSystem
//
//  Created by Alexander Tereshkov on 2/5/18.
//  Copyright © 2018 atereshkov. All rights reserved.
//

import Foundation

class Item {
    
    var uuid = UUID().uuidString
    var characteristic: String
    var object: String
    var value: Bool
    
    init() {
        characteristic = ""
        object = ""
        value = false
    }
    
    init(characteristic: String, object: String, value: Bool) {
        self.characteristic = characteristic
        self.object = object
        self.value = value
    }
    
}

class Matrix {
    
    var matrix: [[Item]] = []
    
    init() { }
    
    init(row: Int, column: Int) {
        for _ in 1...row {
            var innerArray: [Item] = []
            for _ in 1...column {
                innerArray.append(Item())
            }
            matrix.append(innerArray)
        }
    }
    
    func setup(with items: [[Item]]) {
        self.matrix = items
    }
    
}
