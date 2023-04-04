//
//  UIButton + ext.swift
//  TaskList
//
//  Created by Айдар Оспанов on 04.04.2023.
//

import UIKit

extension UIButton {
    
    convenience init(name: String, color: UIColor, action: UIAction?) {
        self.init(frame: .zero, primaryAction: action)
        self.setTitle(name, for: .normal)
        self.backgroundColor = color
        self.tintColor = .white
        self.layer.cornerRadius = 5
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
