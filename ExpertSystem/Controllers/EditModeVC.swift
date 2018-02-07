//
//  EditMode.swift
//  ExpertSystem
//
//  Created by Alexander Tereshkov on 2/5/18.
//  Copyright © 2018 atereshkov. All rights reserved.
//

import UIKit

enum Type: String {
    case object = "Object"
    case characteristic = "Characteristic"
    
    func displayName() -> String {
        switch self {
        case .object: return self.rawValue
        case .characteristic: return self.rawValue
        }
    }
}

class EditModeVC: UIViewController {
    
    fileprivate var characteristicsVC: CharacteristicsTableVC?
    fileprivate var objectsVC: ObjectsTableVC?
    
    var matrix = Matrix()
    
    var objects: [MatrixObject] = [] {
        didSet {
            updateObjectsTableView()
        }
    }
    var characteristics: [MatrixChar] = [] {
        didSet {
            updateCharacteristicsTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StoreManager.shared.reset()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let objectsVC = segue.destination as? ObjectsTableVC {
            self.objectsVC = objectsVC
        } else if let characteristicsVC = segue.destination as? CharacteristicsTableVC {
            self.characteristicsVC = characteristicsVC
        }
    }
    
    // MARK: Actions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        // TODO prepare matrix
        matrix.setup(with: objects, chars: characteristics)
        matrix.print()
        StoreManager.shared.setMatrix(matrix)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addCharacteristic(_ sender: Any) {
        showInputDialog(for: .characteristic)
    }
    
    @IBAction func addObject(_ sender: Any) {
        showInputDialog(for: .object)
    }
    
}

// MARK: TableViews

extension EditModeVC {
    
    func updateObjectsTableView() {
        guard let objectsVC = objectsVC else { return }
        objectsVC.objects = objects
    }
    
    func updateCharacteristicsTableView() {
        guard let charsVC = characteristicsVC else { return }
        charsVC.chars = characteristics
    }
    
    func addCharacteristic(_ item: MatrixChar) {
        self.characteristics.append(item)
    }
    
    func addObject(_ item: MatrixObject) {
        self.objects.append(item)
    }
    
}

// MARK: Input

extension EditModeVC {
    
    func showInputDialog(for item: Type) {
        let alertController = UIAlertController(title: "Enter Details", message: "Enter \(item.displayName()) name", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            guard let name = alertController.textFields?[0].text else { return }
            switch item {
            case .characteristic:
                let newItem = MatrixChar(char: name)
                self.addCharacteristic(newItem)
            case .object:
                let newItem = MatrixObject(object: name)
                newItem.object = name
                self.addObject(newItem)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter \(item.displayName())"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
