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
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 10
    }
}
