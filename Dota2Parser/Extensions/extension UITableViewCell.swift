//
//  extension UITableViewCell.swift
//  Dota2Parser
//
//  Created by Федор Еронин on 16.07.2022.
//

import UIKit

extension UIView {
    
    static func setShadow(to view: UIView, with color: UIColor) {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 8
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 10).cgPath
        view.layer.shouldRasterize = true
    }
}
