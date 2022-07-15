//
//  HeroInfoTabBarController.swift
//  Dota2Parser
//
//  Created by Федор Еронин on 15.07.2022.
//

import UIKit

class HeroInfoTabBarController: UITabBarController {
    
    var heroName: String!
    var heroIcon: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()

    }
    
    private func setTitle() {
        
        let titlelabel = UILabel()
        titlelabel.text = "  " + heroName
        titlelabel.font = UIFont.boldSystemFont(ofSize: 16)
        titlelabel.sizeToFit()
        titlelabel.textAlignment = .center
        
        let titleView = UIView()
        titlelabel.center = titleView.center
        
        guard let url = URL(string: "http://cdn.dota2.com" + heroIcon)
        else { return }
        let heroIconPic = UIImageView()
        heroIconPic.kf.setImage(with: url, placeholder: UIImage(named: "heroIconPlaceholder"))
        guard let _ = heroIconPic.image else { return }
        let heroIconAspect = heroIconPic.image!.size.width /
        heroIconPic.image!.size.height
        heroIconPic.frame = CGRect(
            x: titlelabel.frame.origin.x -
            titlelabel.frame.size.height * heroIconAspect,
            y: titlelabel.frame.origin.y,
            width: titlelabel.frame.size.height * heroIconAspect,
            height: titlelabel.frame.size.height
        )
        heroIconPic.contentMode = .scaleAspectFill
        
        titleView.addSubview(titlelabel)
        titleView.addSubview(heroIconPic)
        
        navigationItem.titleView = titleView
    }
    


}
