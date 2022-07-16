//
//  TableViewCell.swift
//  Dota2Parser
//
//  Created by Федор Еронин on 27.06.2022.
//

import UIKit

class HeroTableViewCell: UITableViewCell {

    @IBOutlet weak var mainAttrImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var roles: UILabel!
    @IBOutlet weak var heroesImage: UIImageView!
    
    @IBOutlet weak var blackView: UIView!
    
    @IBOutlet weak var fakeView: UIView!
    
    func setMainAttrImage(for attr: String) {
            mainAttrImage.image = UIImage(named: attr)
    }
    
    func setShadow(for attr: String) {
        
        var color: UIColor
        
        switch attr {
        case "int":
            color = UIColor(named: "intColor") ?? .blue
        case "agi":
            color = UIColor(named: "agiColor") ?? .green
        default:
            color = UIColor(named: "strColor") ?? .red
        }
        
        UIView.setShadow(to: fakeView, with: color)
    }
}
