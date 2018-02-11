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
            guard matrix.matrix.count > 0 else { return }
            matrix.removeFalseObjectsOn(line: queryLine)
            Swift.print("Removed columns:")
            matrix.print()
            matrix.removeZeroLines()
            Swift.print("Removed zero lines:")
            matrix.print()
            guard matrix.matrix.count > 0 else {
                self.presentResult(result: "UNKNOWN!")
                Swift.print("Unknown object!")
                return
            }
            if matrix.matrix[0].count > 1 {
                let newQueryLine = matrix.lineWithMinSum()
                self.showSolutionDialog(for: matrix, queryLine: newQueryLine)
            } else {
                self.presentResult(result: matrix.matrix[0][0].object.object)
                Swift.print("END object: \(matrix.matrix[0][0].object.object)")
                StoreManager.shared.reset()
            }
        }
        let noAction = UIAlertAction(title: "No", style: .default) { (_) in
            guard matrix.matrix.count > 0 else { return }
            matrix.removeTrueObjectsOn(line: queryLine)
            Swift.print("Removed columns:")
            matrix.print()
            matrix.removeZeroLines()
            Swift.print("Removed zero lines:")
            matrix.print()
            if matrix.matrix[0].count > 1 {
                let newQueryLine = matrix.lineWithMinSum()
                self.showSolutionDialog(for: matrix, queryLine: newQueryLine)
            } else {
                self.presentResult(result: matrix.matrix[0][0].object.object)
                Swift.print("END object: \(matrix.matrix[0][0].object.object)")
                StoreManager.shared.reset()
            }
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func presentResult(result: String) {
        let alert = UIAlertController(title: "Result", message: "Object: \(result)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Actions
    
    @IBAction func backDidPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
