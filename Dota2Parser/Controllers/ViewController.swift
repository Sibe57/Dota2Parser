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
        getHeroes()
    }
    
    func getHeroes() {
        
            guard let url = URL(string: "https://api.opendota.com/api/constants/heroes")
            else { return }
        
            let session = URLSession.shared
            session.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let heroes = try decoder.decode([String: Hero].self, from: data)
                    for (_, hero) in heroes {
                        self.heroes.append(hero)
                    }
                    self.heroes.sort {$0.localizedName < $1.localizedName}
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Decode error: \(error)")
                }
            }.resume()
        }
    
    func getHeroImage(url: String) -> UIImage {
        var image = UIImage()
        let prefix = "http://cdn.dota2.com"
        guard let url = URL(string: prefix + url) else { return image }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            image = UIImage(data: data) ?? UIImage()
        }
        return image
    }
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hero = heroes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "heroCell", for: indexPath) as! HeroesTableViewCell
        cell.heroName.text = hero.localizedName.uppercased()
        cell.roles.text = String(hero.roles.joined(separator: " "))
        
        let prefix = "http://cdn.dota2.com"
        guard let url = URL(string: prefix + hero.img) else { print (hero.img)
            return cell }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(hero.img)
                return }
            DispatchQueue.main.async {
                cell.heroesImage.isHidden = false
                cell.heroesImage.image = UIImage(data: data) ?? UIImage()
            }
            print(hero.localizedName)
        }.resume()
        
        switch hero.primaryAttr {
        case "str":
            cell.mainAttrImage.image = UIImage(named: "str")
        case "agi":
            cell.mainAttrImage.image = UIImage(named: "agi")
        default:
            cell.mainAttrImage.image = UIImage(named: "int")
        }
        return cell
    }
}

