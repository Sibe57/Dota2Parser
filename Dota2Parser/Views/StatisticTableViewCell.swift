//
//  StatisticTableViewCell.swift
//  Dota2Parser
//
//  Created by Федор Еронин on 15.07.2022.
//

import UIKit

class StatisticTableViewCell: UITableViewCell {
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var losesLabel: UILabel!
    @IBOutlet weak var winrateLabel: UILabel!
    @IBOutlet weak var blackView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        blackView.layer.cornerRadius = 10
    }
}
