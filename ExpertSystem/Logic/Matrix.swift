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
    
    // Algorithm
    
    func removeZeroLines() {
        var indexesForRemove: [Int] = []
        for i in 0..<matrix.count {
            var zeroCount = 0
            for j in 0..<matrix[i].count {
                if matrix[i][j].value == false {
                    zeroCount += 1
                }
            }
            if zeroCount == matrix[i].count {
                indexesForRemove.append(i)
            }
        }
        for index in indexesForRemove {
            matrix.remove(at: index)
        }
    }
    
    // Find index of matrix line with minimal sum
    func lineWithMinSum() -> Int {
        var lines: [Int: Int] = [:] // line - count
        for i in 0..<matrix.count {
            var zeroCount = 0
            for j in 0..<matrix[i].count {
                if matrix[i][j].value == true {
                    zeroCount += 1
                }
            }
            lines[i] = zeroCount
        }
        
        let minimum = lines.min { a, b in a.value < b.value }
        return minimum?.key ?? -1
    }
    
    func removeTrueObjectsOn(line: Int) {
        
    }
    
    func remove(column: Int) {
        let row = matrix.count
        let col = matrix[0].count
        
        var newMatrix: [[MatrixItem]] = []
        
        for i in 0..<row {
            for j in 0..<col {
                if j >= column {
                    newMatrix[i][j] = matrix[i][j+1]
                } else {
                    newMatrix[i][j] = matrix[i][j]
                }
            }
        }
        
        self.matrix = newMatrix
    }
    
}
