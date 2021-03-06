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
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
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
        matrix.clear()
        matrix.setup(with: objects, chars: characteristics)
        matrix.print()
        StoreManager.shared.setMatrix(matrix)
        
        // Fill matrix
        let count = matrix.matrix.count * matrix.matrix[0].count
        showRequestDialog(for: matrix, i: 0, j: 0, count: count)
        
        //self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addCharacteristic(_ sender: Any) {
        showInputDialog(for: .characteristic)
    }
    
    @IBAction func addObject(_ sender: Any) {
        showInputDialog(for: .object)
    }
    
    @IBAction func preChar(_ sender: Any) {
        characteristics.append(MatrixChar(char: "Крылья"))
        characteristics.append(MatrixChar(char: "Лапки"))
        characteristics.append(MatrixChar(char: "Двигатель"))
        characteristics.append(MatrixChar(char: "Шасси"))
        characteristics.append(MatrixChar(char: "Клюв"))
    }
    
    @IBAction func preObjects(_ sender: Any) {
        objects.append(MatrixObject(object: "Птица"))
        objects.append(MatrixObject(object: "Самолет"))
        objects.append(MatrixObject(object: "Планер"))
        objects.append(MatrixObject(object: "Муха"))
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
    
    func showRequestDialog(for matrix: Matrix, i: Int, j: Int, count: Int) {
        guard count != 0 else {
            Swift.print("All is done!")
            matrix.print()
            matrix.removeZeroLines()
            Swift.print("Removed zero lines:")
            matrix.print()
            Swift.print("Find minimum line:")
            Swift.print(matrix.lineWithMinSum())
            doneButton.isEnabled = false
            self.dismiss(animated: true, completion: nil)
            return
        }
        let obj = matrix.matrix[i][j].object.object
        let char = matrix.matrix[i][j].characteristic.char
        let msg = "Does \(obj) have \(char)?"
        let alertController = UIAlertController(title: "Matrix Filling", message: msg, preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            matrix.matrix[i][j].value = true
            let newCount = count - 1
            var nextJ = j + 1
            var nextI = i
            if nextJ >= matrix.matrix[i].count {
                nextI = i + 1
                nextJ = 0
            }
            self.showRequestDialog(for: matrix, i: nextI, j: nextJ, count: newCount)
        }
        let noAction = UIAlertAction(title: "No", style: .default) { (_) in
            matrix.matrix[i][j].value = false
            let newCount = count - 1
            var nextJ = j + 1
            var nextI = i
            if nextJ >= matrix.matrix[i].count{
                nextI = i + 1
                nextJ = 0
            }
            self.showRequestDialog(for: matrix, i: nextI, j: nextJ, count: newCount)
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
