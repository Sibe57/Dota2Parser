//
//  PopularItemsTableViewController.swift
//  Dota2Parser
//
//  Created by Федор Еронин on 26.06.2022.
//

import Kingfisher

class PopularItemsTableViewController: UITableViewController {
    
    var heroID: Int!
    var heroName: String!
    var heroIcon: String!
    
    private var popularItems: PopularItems!
    private var items: [Int :Item] = [:]
    private var startItems: [(String, Int)] = []
    private var earlyItems: [(String, Int)] = []
    private var midItems: [(String, Int)] = []
    private var lateItems: [(String, Int)] = []
    
    private let indicator = UIActivityIndicatorView()
    
    private var itemURL: String!
    private var itemName: String!
    
    private var downloadedComponent = 0
    
    
    override func viewDidLoad() {
        navigationItem.backButtonTitle = ""
        super.viewDidLoad()
        fetchData()
        setBackground()
        setActivityIndicator()
        setTitle()
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
        indicator.style = .large
        tableView.addSubview(indicator)
        indicator.startAnimating()
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
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webViewController = segue.destination as! WebViewController
        webViewController.url = itemURL
        webViewController.contentName = itemName
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
        UIView.animate(withDuration: 0.15, delay: 0, options: [], animations: {
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
        
        guard let url = URL(string: "http://cdn.dota2.com" + item.img) else {
            return cell
        }
        
        cell.itemImage.kf.setImage(with: url)
        
        cell.alpha = 0
        UIView.animate(withDuration: 0.15, delay: 0, options: [], animations: {
            cell.alpha = 1
        }, completion: nil)

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        guard let itemName = item?.dname else { return }
        itemURL = "https://dota2.fandom.com/wiki/" +
        itemName.replacingOccurrences(of: " ", with: "_")
        self.itemName = itemName.uppercased()
        performSegue(withIdentifier: "webInfo", sender: self)
    }
}

    
    
    

