//
//  UIStackView + ext.swift
//  TaskList
//
//  Created by Айдар Оспанов on 04.04.2023.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView], spacing: CGFloat, axis: NSLayoutConstraint.Axis = .vertical, distribution: UIStackView.Distribution) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
