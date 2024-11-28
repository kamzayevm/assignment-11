//
//  heroManager.swift
//  assignment 11
//
//  Created by Мубарак Камзаев on 25.11.2024.
//
import Foundation
import UIKit
import Alamofire

protocol heroManagerDelegate{
    func didUpdateSuperhero(_ heroManager: heroManager, hero: HeroModel)
}

struct heroManager{
    let heroApi = "https://akabab.github.io/superhero-api/api/all.json"
     
    var delegate: heroManagerDelegate?
    
    func fetchNews(){
        AF.request(heroApi).responseJSON { response in
            if let data = response.data {
                let decoder = JSONDecoder()
                do {
                    let decoderData = try decoder.decode([Superhero].self, from: data)
                    if let randomHero = decoderData.randomElement(){
                        let name = randomHero.name
                        let image = randomHero.images.md
                        let intelligence = randomHero.powerstats.intelligence
                        let strength = randomHero.powerstats.strength
                        let speed = randomHero.powerstats.speed
                        let durability = randomHero.powerstats.durability
                        let power = randomHero.powerstats.power
                        let combat = randomHero.powerstats.combat
                        let gender = randomHero.appearance.gender
                        let race = randomHero.appearance.race
                        
                        let hero = HeroModel(name: name, image: image, intelligence: intelligence, strength: strength, speed: speed, durability: durability, power: power, combat: combat, gender: gender, race: race)
                        
                        self.delegate!.didUpdateSuperhero(self, hero: hero)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}
