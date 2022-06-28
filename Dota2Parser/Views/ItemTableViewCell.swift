//
//  ItemTableViewCell.swift
//  Dota2Parser
//
//  Created by Федор Еронин on 28.06.2022.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemCost: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var goldImage: UIImageView!
    @IBOutlet weak var rightView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        itemImage.isHidden = true
        setCorners()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setCorners() {
        let rightPath = UIBezierPath(roundedRect: rightView.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        let rightMaskLayer = CAShapeLayer()
        rightMaskLayer.path = rightPath.cgPath
        rightView.layer.mask = rightMaskLayer
        let leftPath = UIBezierPath(roundedRect: rightView.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
        let leftMaskLayer = CAShapeLayer()
        leftMaskLayer.path = leftPath.cgPath
        itemImage.layer.mask = leftMaskLayer
    }

}
