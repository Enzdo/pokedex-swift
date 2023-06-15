//
//  ContentView.swift
//  My-app
//
//  Created by Mechenane Anais on 14/06/2023.
//

import SwiftUI

struct ContentView: View {
    @State var pokemon = [PokemonEntry]()
    @State var searchText = ""
    
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(searchText == "" ? pokemon: pokemon.filter( {$0.name.contains(searchText.lowercased())} )) {
                    entry in
                    HStack {
                        PokemonImage(imageLink: "\(entry.url)")
                            .padding(.trailing, 20)
                            .frame(height: 100)
                        
                        NavigationLink("\(entry.name)".capitalized ,destination:
                                VStack{
                                    PokemonImage(imageLink: "\(entry.url)")
                                            .frame(height: 400)
                                        Text("\(entry.name)")
                                        Text("\(entry.id)")
                                        Text("\(entry.url)")
                                    
                        })
                    }
                }
            }
            
            .onAppear {
                pokeAPI().getData() { pokemon in
                    self.pokemon = pokemon
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("PokedexUI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
