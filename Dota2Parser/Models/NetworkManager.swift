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
    
    
    static func getHeroImage(for url: String, completion: @escaping (_ heroImage: UIImage) -> Void) {
        
        let prefix = "http://cdn.dota2.com"
        guard let url = URL(string: prefix + url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let image = UIImage(data: data) ?? UIImage()
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
