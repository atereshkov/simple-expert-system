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
        self.showSolutionDialog(for: matrix)
    }
    
    // MARK: Logic
    
    fileprivate func showSolutionDialog(for matrix: Matrix) {
        /*
        let msg = "Does \(obj) have \(char)?"
        let alertController = UIAlertController(title: "Matrix Filling", message: msg, preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            
            self.showRequestDialog(for: matrix, i: nextI, j: nextJ, count: newCount)
        }
        let noAction = UIAlertAction(title: "No", style: .default) { (_) in
            
            self.showRequestDialog(for: matrix, i: nextI, j: nextJ, count: newCount)
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        self.present(alertController, animated: true, completion: nil)
        */
    }
    
    // MARK: Actions
    
    @IBAction func backDidPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
