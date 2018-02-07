//
//  CharacteristicsTableViewVC.swift
//  ExpertSystem
//
//  Created by Alexander Tereshkov on 2/5/18.
//  Copyright © 2018 atereshkov. All rights reserved.
//

import UIKit

class CharacteristicsTableVC: UITableViewController {
    
    var chars: [MatrixChar] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: TableView
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableCell else {
            fatalError("The dequeued cell is not an instance of Cell")
        }
        
        guard indexPath.row >= 0 && indexPath.row < chars.count else { return cell }
        let char = chars[indexPath.row]
        cell.bind(item: char.char)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chars.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

