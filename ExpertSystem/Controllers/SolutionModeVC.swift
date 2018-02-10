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
        let char = matrix.matrix[queryLine][0].characteristic.char
        let msg = "Does the object have \(char)?"
        
        let alertController = UIAlertController(title: "Solution Mode", message: msg, preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            
            //self.showSolutionDialog(for: matrix, i: nextI, j: nextJ, count: newCount)
        }
        let noAction = UIAlertAction(title: "No", style: .default) { (_) in
            matrix.remove(column: 1)
            let newQueryLine = matrix.lineWithMinSum()
            Swift.print("removed matrix:::")
            matrix.print()
            self.showSolutionDialog(for: matrix, queryLine: newQueryLine)
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
