//
//  VersusStatisticTableViewController.swift
//  Dota2Parser
//
//  Created by Федор Еронин on 15.07.2022.
//

import UIKit

class VersusStatisticTableViewController: UITableViewController {
    
    var heroID: Int!
    var heroName: String!
    var heroIcon: String!
    
    private var statistics: [VersusHeroStatistic] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print(heroID)
        fetchData()
        
    }
    
    private func fetchData() {
        NetworkManager.getVersusHeroStatistic(for: heroID) { statistics in
            self.statistics = statistics
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        statistics.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "versusStatistic", for: indexPath)
        
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
