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
    
    func setMainAttrImage(for attr: String) {
        switch attr {
        case "str":
            mainAttrImage.image = UIImage(named: "str")
        case "agi":
            mainAttrImage.image = UIImage(named: "agi")
        default:
            mainAttrImage.image = UIImage(named: "int")
        }
    }
}
