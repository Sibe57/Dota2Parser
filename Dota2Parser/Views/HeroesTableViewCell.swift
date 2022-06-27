//
//  TableViewCell.swift
//  Dota2Parser
//
//  Created by Федор Еронин on 27.06.2022.
//

import UIKit

class HeroesTableViewCell: UITableViewCell {

    @IBOutlet weak var mainAttrImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var roles: UILabel!
    @IBOutlet weak var heroesImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        heroesImage.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
