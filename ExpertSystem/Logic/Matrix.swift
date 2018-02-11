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
    
    init(row: Int, column: Int) {
        for _ in 1...row {
            var innerArray: [MatrixItem] = []
            for _ in 1...column {
                innerArray.append(MatrixItem())
            }
            matrix.append(innerArray)
        }
    }

    // MARK: Helpers
    
    func clear() {
        self.matrix = []
    }
    
    func print() {
        guard matrix.count > 0 else {
            Swift.print("Print < 0")
            return
        }
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
        for index in indexesForRemove.reversed() {
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
        var removeColumns: [Int] = []
        for j in 0..<matrix[line].count {
            if matrix[line][j].value == true {
                removeColumns.append(j)
            }
        }
        remove(columns: removeColumns)
    }
    
    func removeFalseObjectsOn(line: Int) {
        var removeColumns: [Int] = []
        for j in 0..<matrix[line].count {
            if matrix[line][j].value == false {
                removeColumns.append(j)
            }
        }
        remove(columns: removeColumns)
    }
    
    func remove(column: Int) {
        let row = matrix.count
        let col = matrix[0].count
        
        let m = Matrix(row: row, column: col - 1)
        var newMatrix: [[MatrixItem]] = m.matrix
        
        for i in 0..<row {
            for j in 0..<col-1 {
                if j >= column {
                    newMatrix[i][j] = matrix[i][j+1]
                } else {
                    newMatrix[i][j] = matrix[i][j]
                }
            }
        }
        
        self.matrix = newMatrix
    }
    
    func remove(columns: [Int]) {
        for column in columns.reversed() {
            self.remove(column: column)
        }
    }
    
}
