//
//  NetworkManager.swift
//  Dota2Parser
//
//  Created by Федор Еронин on 24.06.2022.
//

import UIKit

class NetworkManager {
    
    static func getHeroes(completion: @escaping (_ heroes: [Hero]) -> Void) {
        
        var heroes: [Hero] = []
        
        guard let url = URL(string: "https://api.opendota.com/api/constants/heroes")
        else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let heroesDict = try decoder.decode([String: Hero].self, from: data)
                for (_, hero) in heroesDict {
                    heroes.append(hero)
                }
                heroes.sort {$0.localizedName < $1.localizedName}
                DispatchQueue.main.async {
                    completion(heroes)
                }
            } catch {
                print("Decode error: \(error)")
            }
        }.resume()
    }
    
    static func getPopularItems(
        for heroID: Int,
        completion: @escaping (_ popularItems: PopularItems) -> Void
    ) {
        guard let url = URL(string: "https://api.opendota.com/api/heroes/\(heroID)/itemPopularity")
        else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let popularItems = try decoder.decode(PopularItems.self, from: data)
                DispatchQueue.main.async {
                    completion(popularItems)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    static func getItems(completiom: @escaping (_ items: [Item]) -> Void) {
        guard let url = URL(string: "https://api.opendota.com/api/constants/items")
        else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, errors in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let itemsDict  = try decoder.decode([String: Item].self, from: data)
                var items: [Item] = []
                for (_, item) in itemsDict {
                    items.append(item)
                }
                DispatchQueue.main.async {
                    completiom(items)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
