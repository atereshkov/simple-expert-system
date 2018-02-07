//
//  Models.swift
//  ExpertSystem
//
//  Created by Alexander Tereshkov on 2/7/18.
//  Copyright © 2018 atereshkov. All rights reserved.
//

import Foundation

class MatrixItem {
    
    var uuid = UUID().uuidString
    var characteristic: MatrixChar
    var object: MatrixObject
    var value: Bool
    
    init() {
        characteristic = MatrixChar()
        object = MatrixObject()
        value = false
    }
    
    init(characteristic: MatrixChar, object: MatrixObject, value: Bool) {
        self.characteristic = characteristic
        self.object = object
        self.value = value
    }
    
}

class MatrixObject {
    
    var object: String
    
    init() {
        self.object = ""
    }
    
    init(object: String) {
        self.object = object
    }
    
}

class MatrixChar {
    
    var char: String
    
    init() {
        self.char = ""
    }
    
    init(char: String) {
        self.char = char
    }
    
}
