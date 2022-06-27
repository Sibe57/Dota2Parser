//
//  PopularItemsTableViewController.swift
//  Dota2Parser
//
//  Created by Федор Еронин on 26.06.2022.
//

import UIKit

class PopularItemsTableViewController: UITableViewController {
    
    var popularItems: PopularItems!
    var itemDict: [String: String] = [:]
    var startItems: [(String, Int)] = []
    var earlyItems: [(String, Int)] = []
    var midItems: [(String, Int)] = []
    var lateItems: [(String, Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startItems = popularItems.startGameItems.sorted { $0.value > $1.value}
        earlyItems = popularItems.earlyGameItems.sorted { $0.value > $1.value}
        midItems = popularItems.midGameItems.sorted { $0.value > $1.value}
        lateItems = popularItems.lateGameItems.sorted { $0.value > $1.value}
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Items For Start"
        case 1:
            return "Items For Early Game"
        case 2:
            return "Items For Mid Game"
        default:
            return "Items For Late Game"
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        var configure = cell.defaultContentConfiguration()
        
        switch indexPath.section {
        case 0:
            configure.text = "\(itemDict[startItems[indexPath.row].0] ?? "")"
            configure.secondaryText = "Rate of buy: \(startItems[indexPath.row].1)"
        case 1:
            configure.text = "\(itemDict[earlyItems[indexPath.row].0] ?? "")"
            configure.secondaryText = "Rate of buy: \(earlyItems[indexPath.row].1)"
        case 2:
            configure.text = "\(itemDict[midItems[indexPath.row].0] ?? "")"
            configure.secondaryText = "Rate of buy: \(midItems[indexPath.row].1)"
        default:
            configure.text = "\(itemDict[lateItems[indexPath.row].0] ?? "")"
            configure.secondaryText = "Rate of buy: \(lateItems[indexPath.row].1)"
        }
        cell.contentConfiguration = configure

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
