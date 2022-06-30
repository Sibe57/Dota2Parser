//
//  ViewController.swift
//  Dota2Parser
//
//  Created by Федор Еронин on 24.06.2022.
//

import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var heroID: Int!
    var heroName: String!
    var heroIcon: String!
    var heroes: [Hero] = []
    var filteredHeroes: [Hero] = []
    
    
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
        let popularItemsViewControler = segue.destination as! PopularItemsTableViewController
        popularItemsViewControler.heroID = heroID
        popularItemsViewControler.heroName = heroName
        popularItemsViewControler.heroIcon = heroIcon
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hero = filteredHeroes[indexPath.row]
        heroID = hero.id
        heroName = hero.localizedName.uppercased()
        heroIcon = hero.icon
        performSegue(withIdentifier: "toPopularItems", sender: self)
    }
}



extension ViewController: UITableViewDataSource {
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
        
        NetworkManager.getDota2Image(for: hero.img) { heroImage in
            cell.heroesImage.isHidden = false
            cell.heroesImage.image = heroImage
        }
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredHeroes = searchText.isEmpty ? heroes : heroes.filter {(hero: Hero) -> Bool in
            let name = hero.localizedName
            return name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
}

