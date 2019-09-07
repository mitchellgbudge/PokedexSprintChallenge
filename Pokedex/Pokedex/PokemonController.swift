//
//  PokemonController.swift
//  Pokedex
//
//  Created by Mitchell Budge on 9/7/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

class PokemonController {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func getPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        let requestURL = baseURL.appendingPathComponent(searchTerm)
        
        URLSession.shared.dataTask(with: requestURL) { (jsonData, _, error) in
            if let error = error {
                print("Error getting pokemon: \(error)")
                completion(.failure(error))
                return
            }
            guard let pokemonData = jsonData else {
                print("Error retrieving data from data task")
                completion(.failure(NSError()))
                return
            }
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: pokemonData)
                print(pokemon)
                completion(.success(pokemon))
            } catch {
                print("Error decoding data to type Pokemon: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
    
}
