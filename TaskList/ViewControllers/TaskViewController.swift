//
//  TaskViewController.swift
//  TaskList
//
//  Created by Айдар Оспанов on 04.04.2023.
//

import UIKit

class TaskViewController: UIViewController {
    
    private var stackView = UIStackView()
    
    private lazy var taskTextField: UITextField = {
        let textField = UITextField()
        textField.leftView = .init(
            frame: CGRect(x: 0, y: 0, width: 10, height: 0)
        )
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.backgroundColor = .systemGray5
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.placeholder = "New Task"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var saveTaskButton = UIButton(
        name: "Save Task",
        color: UIColor(named: "MilkBlue") ?? .green,
        action: UIAction { [unowned self]  _ in
            dismiss(animated: true)
        }
    )
    
    private lazy var canselTaskButton = UIButton(
        name: "Cansel Task",
        color: .orange,
        action: UIAction { [unowned self] _ in
            save()
        }
    )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupStackView()
        setupLayout()
    }
    
    private func setupStackView() {
        stackView = UIStackView(
            arrangedSubviews: [taskTextField, saveTaskButton, canselTaskButton],
            spacing: 15,
            distribution: .fillEqually
        )
        
        view.addSubview(stackView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
}

extension TaskViewController {
    private func save() {
        dismiss(animated: true)
    }
}
