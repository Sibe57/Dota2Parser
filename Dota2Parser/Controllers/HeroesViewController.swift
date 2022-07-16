//
//  ViewController.swift
//  Dota2Parser
//
//  Created by Федор Еронин on 24.06.2022.
//

import Kingfisher

class HeroesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var heroID: Int!
    private var heroName: String!
    private var heroIcon: String!
    private var heroes: [Hero] = []
    private var filteredHeroes: [Hero] = []
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        searchBar.delegate = self
        NetworkManager.getHeroes { heroes in
            self.heroes = heroes
            self.filteredHeroes = heroes
            self.tableView.reloadData()
        }
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    //MARK: - Navigations
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let tabBarController = segue.destination as? HeroInfoTabBarController
        else { return }
        
        tabBarController.heroName = heroName
        tabBarController.heroIcon = heroIcon
        
        guard let controllers = tabBarController.viewControllers else { return }
        
        for controller in controllers {
            if let popularItemsViewControler = controller as?
                PopularItemsTableViewController {
                
                popularItemsViewControler.heroID = heroID
                popularItemsViewControler.heroName = heroName
                popularItemsViewControler.heroIcon = heroIcon
            } else if let versusStatisticVC = controller as?
                        VersusStatisticTableViewController {
                versusStatisticVC.heroID = heroID
                versusStatisticVC.heroName = heroName
                versusStatisticVC.heroIcon = heroIcon
                versusStatisticVC.heroes = heroes
            }
        }
    }
    
    
}

extension HeroesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hero = filteredHeroes[indexPath.row]
        heroID = hero.id
        heroName = hero.localizedName.uppercased()
        heroIcon = hero.icon
        let cell =  self.tableView.cellForRow(at: indexPath)
        guard let cell = cell else { return }
        UIView.animate(withDuration: 0.1,delay: 0, options:[.curveEaseOut]) {
            cell.transform = cell.transform.scaledBy(x: 0.9, y: 0.9)
        } completion: {_ in
            UIView.animate(withDuration: 0.1) {
                cell.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }

        performSegue(withIdentifier: "toHeroInfo", sender: self)
    }
}



extension HeroesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredHeroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hero = filteredHeroes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "heroCell",
            for: indexPath) as! HeroTableViewCell
        
        cell.heroName.text = hero.localizedName.uppercased()
        cell.roles.text = String(hero.roles.joined(separator: " "))
        cell.setMainAttrImage(for: hero.primaryAttr)
        cell.setShadow(for: hero.primaryAttr)
        
        guard let url = URL(string: "http://cdn.dota2.com" + hero.img) else {
            return cell
        }
        cell.heroesImage.kf.setImage(with: url)
        
        let bgSelectedCellView = UIView()
        bgSelectedCellView.backgroundColor = .clear
        cell.selectedBackgroundView = bgSelectedCellView

        return cell
    }
}

extension HeroesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredHeroes = searchText.isEmpty ? heroes : heroes.filter {(hero: Hero) -> Bool in
            let name = hero.localizedName
            return name.range(of: searchText,
                              options: .caseInsensitive,
                              range: nil,
                              locale: nil) != nil
        }
        tableView.reloadData()
    }
}

