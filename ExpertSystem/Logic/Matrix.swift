//
//  Matrix.swift
//  ExpertSystem
//
//  Created by Alexander Tereshkov on 2/5/18.
//  Copyright © 2018 atereshkov. All rights reserved.
//

import Foundation

class Matrix {
    
    var matrix: [[MatrixItem]] = []
    
    // MARK: Init
    
    init() { }
    
    func setup(with items: [[MatrixItem]]) {
        self.matrix = items
    }
    
    func setup(with objects: [MatrixObject], chars: [MatrixChar]) {
        for char in chars {
            var innerArray: [MatrixItem] = []
            for object in objects {
                innerArray.append(MatrixItem(characteristic: char, object: object, value: false))
            }
            self.matrix.append(innerArray)
        }
    }
    
    // MARK: Helpers
    
    func clear() {
        self.matrix = []
    }
    
    func print() {
        var topStr = ""
        for obj in 0..<matrix[0].count {
            topStr += "     "
            topStr += String(describing: matrix[0][obj].object.object)
        }
        Swift.print(topStr)
        
        for i in 0..<matrix.count {
            var line = matrix[i][0].characteristic.char + "  "
            for j in 0..<matrix[i].count {
                line += String(matrix[i][j].value)
                line += "  "
            }
            Swift.print(line)
        }
    }
    
}
