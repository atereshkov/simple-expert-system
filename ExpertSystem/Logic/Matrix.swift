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
    
    // MARK: Init
    
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
    
    func setup(with objects: [Item], chars: [Item]) {
        for char in chars {
            var innerArray: [Item] = []
            for object in objects {
                let charStr = char.characteristic
                let objStr = object.object
                innerArray.append(Item(characteristic: charStr, object: objStr, value: false))
            }
            self.matrix.append(innerArray)
        }
    }
    
    // MARK: Helpers
    
    func print() {
        var topStr = ""
        for obj in 0..<matrix[0].count {
            topStr += "     "
            topStr += String(describing: matrix[0][obj].object)
        }
        Swift.print(topStr)
        
        for i in 0..<matrix.count {
            var line = matrix[i][0].characteristic + "  "
            for j in 0..<matrix[i].count {
                line += String(matrix[i][j].value)
                line += "  "
            }
            Swift.print(line)
        }
    }
    
}
