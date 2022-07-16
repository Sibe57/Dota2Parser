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
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 8
        
        let path = UIBezierPath(roundedRect: view.bounds, cornerRadius: 16)
        view.layer.shadowPath = path.cgPath
    }
}
