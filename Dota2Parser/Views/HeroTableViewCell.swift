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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        heroesImage.isHidden = true
        setCorners()
    }
    
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setCorners() {
        let rightPath = UIBezierPath(roundedRect: mainAttrImage.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        let rightMaskLayer = CAShapeLayer()
        rightMaskLayer.path = rightPath.cgPath
        mainAttrImage.layer.mask = rightMaskLayer
        let leftPath = UIBezierPath(roundedRect: heroesImage.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
        let leftMaskLayer = CAShapeLayer()
        leftMaskLayer.path = leftPath.cgPath
        heroesImage.layer.mask = leftMaskLayer
    }

}
