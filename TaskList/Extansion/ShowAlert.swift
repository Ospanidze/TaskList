//
//  ShowAlert.swift
//  TaskList
//
//  Created by Айдар Оспанов on 04.04.2023.
//

import UIKit

extension UIViewController {
    
    func showAlert(withTitle title: String, andMessage message: String, nameTask: String = "", completion: @escaping(String) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save Task", style: .default) { _ in
            guard let task = alert.textFields?.first?.text, !task.isEmpty else {
                return
            }
            completion(task)
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField { textField in
            textField.placeholder = "Name Task"
            if nameTask != "" {
                textField.text = nameTask
            }
        }
        
        present(alert, animated: true)
    }
}
