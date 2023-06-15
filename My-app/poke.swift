//
//  poke.swift
//  My-app
//
//  Created by Mechenane Anais on 14/06/2023.
//
// https://pokeapi.co/api/v2/ability/?limit=20&offset=20

import Foundation


struct Pokemon : Codable{
    var results: [PokemonEntry]
}

struct PokemonEntry : Codable, Identifiable  {
    let id = UUID()
    var name: String
    var url: String
}

class pokeAPI{
    func getData(completion: @escaping ([PokemonEntry]) -> ()){
        guard let url =  URL(string: "https://pokeapi.co/api/v2/pokemon/") else{
            return
        }
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard let data = data else{ return }
            
            let pokemonList = try! JSONDecoder().decode(Pokemon.self, from: data)
            
            DispatchQueue.main.sync {
                completion(pokemonList.results)
            }
            
        }.resume()
    }
}
