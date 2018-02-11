//
//  SolutionMode.swift
//  ExpertSystem
//
//  Created by Alexander Tereshkov on 2/5/18.
//  Copyright © 2018 atereshkov. All rights reserved.
//

import UIKit

class SolutionModeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let matrix = StoreManager.shared.matrix else { return }
        // Start with query line
        let queryLine = matrix.lineWithMinSum()
        self.showSolutionDialog(for: matrix, queryLine: queryLine)
    }
    
    // MARK: Logic
    
    fileprivate func showSolutionDialog(for matrix: Matrix, queryLine: Int) {
        guard matrix.matrix.count > 0 else {
            Swift.print("ShowSolutionDialog matrix.count < 0")
            return
        }
        let char = matrix.matrix[queryLine][0].characteristic.char
        let msg = "Does the object have \(char)?"
        
        let alertController = UIAlertController(title: "Solution Mode", message: msg, preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            matrix.removeTrueObjectsOn(line: queryLine)
            Swift.print("Removed columns:")
            matrix.print()
            if matrix.matrix[0].count > 0 {
                matrix.removeZeroLines()
                Swift.print("Removed zero lines:")
                matrix.print()
                let newQueryLine = matrix.lineWithMinSum()
                self.showSolutionDialog(for: matrix, queryLine: newQueryLine)
            } else {
                Swift.print("END object: \(matrix.matrix[0][0].object)")
            }
        }
        let noAction = UIAlertAction(title: "No", style: .default) { (_) in
            matrix.removeTrueObjectsOn(line: queryLine)
            Swift.print("Removed columns:")
            matrix.print()
            if matrix.matrix[0].count > 0 {
                matrix.removeZeroLines()
                Swift.print("Removed zero lines:")
                matrix.print()
                let newQueryLine = matrix.lineWithMinSum()
                self.showSolutionDialog(for: matrix, queryLine: newQueryLine)
            } else {
                Swift.print("END object: \(matrix.matrix[0][0].object)")
            }
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Actions
    
    @IBAction func backDidPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
