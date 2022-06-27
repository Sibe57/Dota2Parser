//
//  ViewController.swift
//  Dota2Parser
//
//  Created by Федор Еронин on 24.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var heroes: [Hero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.getHeroes { heroes in
            self.heroes = heroes
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hero = heroes[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "heroCell",
            for: indexPath) as! HeroesTableViewCell
        cell.heroName.text = hero.localizedName.uppercased()
        cell.roles.text = String(hero.roles.joined(separator: " "))
        cell.setMainAttrImage(for: hero.primaryAttr)
        
        NetworkManager.getHeroImage(for: hero.img) { heroImage in
            cell.heroesImage.isHidden = false
            cell.heroesImage.image = heroImage
        }
        
        return cell
    }
}

