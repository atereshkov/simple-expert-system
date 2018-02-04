//
//  ViewController.swift
//  ExpertSystem
//
//  Created by Alexander Tereshkov on 2/5/18.
//  Copyright © 2018 atereshkov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: Actions
    
    
    @IBAction func editMode(_ sender: Any) {
        let storyboard = UIStoryboard(name: "EditMode", bundle: nil)
        if let editModeVC = storyboard.instantiateInitialViewController() {
            self.present(editModeVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func solutionMode(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SolutionMode", bundle: nil)
        if let solutionModeVC = storyboard.instantiateInitialViewController() {
            self.present(solutionModeVC, animated: true, completion: nil)
        }
    }

}
