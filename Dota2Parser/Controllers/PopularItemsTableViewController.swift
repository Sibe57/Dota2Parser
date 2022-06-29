//
//  PopularItemsTableViewController.swift
//  Dota2Parser
//
//  Created by Федор Еронин on 26.06.2022.
//

import UIKit
import SwiftUI

class PopularItemsTableViewController: UITableViewController {
    
    var heroID: Int!
    var popularItems: PopularItems!
    var items: [Int :Item] = [:]
    var heroName = ""
    let indicator = UIActivityIndicatorView()
    
    var downloadedComponent = 0
    

    var startItems: [(String, Int)] = []
    var earlyItems: [(String, Int)] = []
    var midItems: [(String, Int)] = []
    var lateItems: [(String, Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = heroName
        fetchData()
        setBackground()
        setActivityIndicator()
    }
    
    private func setBackground() {
        tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        tableView.backgroundView?.contentMode = .scaleAspectFill
    }
    
    private func fetchData() {
        NetworkManager.getPopularItems(for: heroID) { popularItems in
            self.popularItems = popularItems
            self.createListsOfItems()
            self.tableView.reloadData()
            self.downloadedComponent += 1
        }
        
        NetworkManager.getItems() { items in
            for item in items {
                self.items[item.id] = item
            }
            self.tableView.reloadData()
            self.downloadedComponent += 1
        }
    }
    
    private func createListsOfItems() {
        startItems = popularItems.startGameItems.sorted { $0.value > $1.value}
        earlyItems = popularItems.earlyGameItems.sorted { $0.value > $1.value}
        midItems = popularItems.midGameItems.sorted { $0.value > $1.value}
        lateItems = popularItems.lateGameItems.sorted { $0.value > $1.value}
    }
    
    private func setActivityIndicator () {
        indicator.center = view.center
        tableView.addSubview(indicator)
        indicator.startAnimating()
        
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return startItems.count < 6 ? startItems.count : 6
        case 1:
            return earlyItems.count < 6 ? earlyItems.count : 6
        case 2:
            return midItems.count < 6 ? midItems.count : 6
        default:
            return lateItems.count < 6 ? lateItems.count : 6
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard downloadedComponent == 2 else { return nil }
        let headerLabel = UILabel()
        headerLabel.layer.frame.origin.y += 20
        headerLabel.textAlignment = .center
        
        headerLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        switch section {
        case 0:
            headerLabel.text = "FOR START"
        case 1:
            headerLabel.text = "EARLY GAME"
        case 2:
            headerLabel.text = "MID GAME"
        default:
            headerLabel.text = "LATE GAME"
        }
        headerLabel.alpha = 0
        UIView.animate(withDuration: 0.25, delay: 0, options: [], animations: {
            headerLabel.alpha = 1
        }, completion: nil)
        return headerLabel
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item: Item?
        switch indexPath.section {
        case 0:
            item = items[Int(startItems[indexPath.row].0)!] ?? nil
        case 1:
            item = items[Int(earlyItems[indexPath.row].0)!] ?? nil
        case 2:
            item = items[Int(midItems[indexPath.row].0)!] ?? nil
        default:
            item = items[Int(lateItems[indexPath.row].0)!] ?? nil
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as!
        ItemTableViewCell
        
        guard let item = item else {
            return cell
        }
        indicator.stopAnimating()

        if let cost = item.cost {
            cell.itemCost.text = String(cost)
        } else {
            cell.itemCost.isHidden = true
            cell.goldImage.isHidden = true
        }
        cell.itemName.text = item.dname?.uppercased()
        
        NetworkManager.getDota2Image(for: item.img) { dota2Image in
            cell.itemImage.image = dota2Image
            cell.itemImage.isHidden = false
        }
        cell.alpha = 0
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseIn], animations: {
            cell.alpha = 1
        }, completion: nil)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
