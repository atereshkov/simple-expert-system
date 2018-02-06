//
//  StoreManager.swift
//  ExpertSystem
//
//  Created by Alexander Tereshkov on 2/7/18.
//  Copyright © 2018 atereshkov. All rights reserved.
//

import Foundation

class StoreManager: NSObject {
    
    static let shared = StoreManager()
    
    var matrix: Matrix?
    
    func setMatrix(_ matrix: Matrix) {
        self.matrix = matrix
    }
    
    func reset() {
        self.matrix = nil
    }
    
}
