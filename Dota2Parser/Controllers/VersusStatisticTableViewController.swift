//
//  VersusStatisticTableViewController.swift
//  Dota2Parser
//
//  Created by Федор Еронин on 15.07.2022.
//

import UIKit

class VersusStatisticTableViewController: UITableViewController {
    
    var heroes: [Hero]!
    
    var heroID: Int!
    var heroName: String!
    var heroIcon: String!
    
    private var statistics: [VersusHeroStatistic] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    private func fetchData() {
        NetworkManager.getVersusHeroStatistic(for: heroID) { statistics in
            self.statistics = statistics
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func searchHero(by id: Int) -> Hero? {
        for hero in heroes {
            if hero.id == id {
                return hero
            }
        }
        return nil
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        statistics.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "versusStatistic", for: indexPath) as! StatisticTableViewCell
        
        let statistic = statistics[indexPath.row]
        
        guard let matchupsHero = searchHero(by: statistic.heroId) else { return cell }
        
        guard let url = URL(string: "http://cdn.dota2.com" + matchupsHero.img)
        else { return cell }
        
        cell.heroImage.kf.setImage(with: url)
        cell.heroName.text = matchupsHero.localizedName.uppercased()
        cell.winsLabel.text = "\(statistic.wins)"
        cell.losesLabel.text = "\(statistic.loses)"
        cell.winrateLabel.text = String(format: "%.f", statistic.winRate) + "%"
        
        let winLoseColor = statistic.wins >= statistic.loses
        ? UIColor(named: "winGreen")
        : UIColor(named: "loseRed")
        
        UIView.setShadow(to: cell.blackView, with: winLoseColor ?? .green)
        cell.winrateLabel.textColor = winLoseColor!
      
        return cell
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
