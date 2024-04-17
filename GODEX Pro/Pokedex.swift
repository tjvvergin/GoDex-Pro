//
//  Pokedex.swift
//  GODEX Pro
//
//  Created by Tyler Vergin on 5/10/23.
//
import Foundation
import SwiftUI


class Pokedex: Identifiable, ObservableObject {
    var pokemonArr: [Pokemon]
    @Published var relevantPokedexArr: [Pokemon] = []
    @Published var isComplete = false
    @Published var backGroundGradient: [Color] = [.red, .white]
    @Published var communityDays: CommunityDays = []
    var averageAttack = 0, averageDefense = 0, averageStamina = 0
    
    init() {
        pokemonArr = []
    }
    
    func initPokedexWithValues() {
        //store json into files
        //MyAPIHandler.storeAPIRequest(fileName: "pokemon_names.json")
        //read from files into dictionary
        let PokemonNamesArr = APIHandler.readJSONFile(fileName: "pokemon_names.json", returnType: PokemonNames.self)
        if let PokemonNamesArr = PokemonNamesArr {
            //init array with empty pokemon
            pokemonArr = Array(repeating: Pokemon(id: 0, name: ""), count: PokemonNamesArr.count + 1)
            //fill array with actual pokemon values
            for (x,y) in PokemonNamesArr {
                pokemonArr[x] = (Pokemon(id: x, name: y.name))
            }
            //fill pokemon with all associated images
            for i in 1..<pokemonArr.count {
                pokemonArr[i].initPokemonImages()
            }
            
            //Run the rest of the initializers
            initReleased()
            initGenerations()
            initEvolutions()
            initMegaEvolutions()
            initIsBaby()
            initShiny()
            initPokemonTyping()
            initMaxCP()
            initStats()
            initSize()
            initGenders()
            testArray()
            generateAverages()
            initCommunityDays()
            initRelevantPokedexArr()
            print ("Pokemon sorted")
            DispatchQueue.main.async {
                self.isComplete = true
            }
            
        } else {
            pokemonArr = []
            print("Error occurred when Initializing pokemonArr")
            
        }
    }
    //function that returns all useful pokedex entries to be used in collectionView
    func initRelevantPokedexArr() {
        var output: [Pokemon] = []
        if relevantPokedexArr.isEmpty {
            for i in 1..<pokemonArr.count {
                if pokemonArr[i].mainImage != nil && pokemonArr[i].id != 0 {
                    output.append(pokemonArr[i])
                }
            }
            DispatchQueue.main.async {
                self.relevantPokedexArr = output
            }
            
        }
    }
    
    func getPokedexArr() -> [Pokemon] {
        return pokemonArr
    }
    func getPokemon(name: String) -> Pokemon? {
        for pokemon in pokemonArr {
            if pokemon.name == name {
                return pokemon
            }
        }
        return nil
    }
    func searchPokedexArr(query: String) -> [Pokemon] {
        var output: [Pokemon] = []
        if query != "" {
            //loop through PokemonArr and find pokemon containing text
            for pokemon in relevantPokedexArr {
                if pokemon.name.lowercased().contains(query.lowercased()) {
                    output.append(pokemon)
                }
            }
            return output
        } else { return relevantPokedexArr }
    }
    
    func testArray() {
        for pokemon in pokemonArr {
            
            if pokemon.mainImage != nil && (pokemon.height == nil || pokemon.weight == nil) {
                print("#\(pokemon.id) \(pokemon.name): Missing Size")
            }
                
            if pokemon.mainImage != nil && (pokemon.attack == nil || pokemon.defense == nil || pokemon.stamina == nil) {
                print("#\(pokemon.id) \(pokemon.name): Missing Stats")
            }
            
            if pokemon.mainImage != nil && (pokemon.malePercent == nil || pokemon.femalePercent == nil) {
                print("#\(pokemon.id) \(pokemon.name): Missing Gender Ratios")
            }
        }
    }
    
    func generateAverages() {
        var count = 0
        var totalStamina = 0, totalAttack = 0, totalDefense = 0
        
        for pokemon in pokemonArr {
            if pokemon.stamina != nil && pokemon.attack != nil && pokemon.defense != nil {
                totalAttack += pokemon.attack!
                totalDefense += pokemon.defense!
                totalStamina += pokemon.stamina!
                count += 1
            }
        }
        self.averageAttack = totalAttack / count
        self.averageDefense = totalDefense / count
        self.averageStamina = totalStamina / count
    }
    //MARK: Generic initializers
    func initCommunityDays() {
        let tempCollection = APIHandler.readJSONFile(fileName: "community_days.json", returnType: CommunityDays.self)
        if let tempCollection = tempCollection {
            DispatchQueue.main.async {
                self.communityDays = tempCollection.reversed()
            }
            
        }
    }
        
    
    func initGenders() {
        let tempCollection = APIHandler.readJSONFile(fileName: "pokemon_genders.json", returnType: PokemonGenders.self)
        if let tempCollection = tempCollection {
            //go into each tempCollection.the(...) to fill in male and female percent values
            for (pokemon) in tempCollection.the0M1F {
                if pokemon.form == nil || pokemon.form == pokemonArr[pokemon.pokemonID].baseForm {
                    pokemonArr[pokemon.pokemonID].femalePercent = 1.0
                    pokemonArr[pokemon.pokemonID].malePercent = 0.0
                }
            }
            
            for (pokemon) in tempCollection.the1M0F {
                if pokemon.form == nil || pokemon.form == pokemonArr[pokemon.pokemonID].baseForm {
                    pokemonArr[pokemon.pokemonID].femalePercent = 0.0
                    pokemonArr[pokemon.pokemonID].malePercent = 1.0
                }
            }
        
            for (pokemon) in tempCollection.the1M1F {
                if pokemon.form == nil || pokemon.form == pokemonArr[pokemon.pokemonID].baseForm {
                    pokemonArr[pokemon.pokemonID].femalePercent = 0.5
                    pokemonArr[pokemon.pokemonID].malePercent = 0.5
                }
            }
            
            for (pokemon) in tempCollection.the1M3F {
                if pokemon.form == nil || pokemon.form == pokemonArr[pokemon.pokemonID].baseForm {
                    pokemonArr[pokemon.pokemonID].femalePercent = 0.25
                    pokemonArr[pokemon.pokemonID].malePercent = 0.75
                }
            }
            
            for (pokemon) in tempCollection.the1M7F {
                if pokemon.form == nil || pokemon.form == pokemonArr[pokemon.pokemonID].baseForm {
                    pokemonArr[pokemon.pokemonID].femalePercent = 0.125
                    pokemonArr[pokemon.pokemonID].malePercent = 0.875
                }
            }
            
            for (pokemon) in tempCollection.the3M1F {
                if pokemon.form == nil || pokemon.form == pokemonArr[pokemon.pokemonID].baseForm {
                    pokemonArr[pokemon.pokemonID].femalePercent = 0.25
                    pokemonArr[pokemon.pokemonID].malePercent = 0.75
                }
            }
            
            for (pokemon) in tempCollection.the7M1F {
                if pokemon.form == nil || pokemon.form == pokemonArr[pokemon.pokemonID].baseForm {
                    pokemonArr[pokemon.pokemonID].femalePercent = 0.875
                    pokemonArr[pokemon.pokemonID].malePercent = 0.125
                }
            }
            
            for (pokemon) in tempCollection.genderless {
                if pokemon.form == nil || pokemon.form == pokemonArr[pokemon.pokemonID].baseForm {
                    pokemonArr[pokemon.pokemonID].femalePercent = 0.0
                    pokemonArr[pokemon.pokemonID].malePercent = 0.0
                }
            }
            
        }
    }
    
    func initStats() {
        let tempCollection = APIHandler.readJSONFile(fileName: "pokemon_stats.json", returnType: PokemonStats.self)
        if let tempCollection = tempCollection {
            for pokemon in tempCollection {
                if pokemon.form == nil || pokemon.form == pokemonArr[pokemon.pokemonID].baseForm {
                    pokemonArr[pokemon.pokemonID].stamina = pokemon.baseStamina
                    pokemonArr[pokemon.pokemonID].attack = pokemon.baseAttack
                    pokemonArr[pokemon.pokemonID].defense = pokemon.baseDefense
                }
            }
        }
    }
    
    func initSize() {
        let tempCollection = APIHandler.readJSONFile(fileName: "pokemon_height_weight_scale.json", returnType: PokemonSizes.self)
        if let tempCollection = tempCollection {
            for pokemon in tempCollection {
                if pokemon.form == "Normal" {
                    pokemonArr[pokemon.pokemonID].height = pokemon.pokedexHeight
                    pokemonArr[pokemon.pokemonID].weight = pokemon.pokedexWeight
                }
            }
        }
    }
    
    func initReleased() {
        let tempCollection = APIHandler.readJSONFile(fileName: "released_pokemon.json", returnType: ReleasedPokemons.self)
        if let tempCollection = tempCollection {
            for (x,y) in tempCollection {
                if x < pokemonArr.count {
                pokemonArr[x].setReleased(true)
                } else {
                    print("Error Pokemon id: \(x), name: \(y.name)")
                }
            }
        } else {
            print ("Error instantiating collection for initReleased")
        }
    }
    
    func initGenerations() {
        let tempCollection = APIHandler.readJSONFile(fileName: "pokemon_generations.json", returnType: PokemonGenerations.self)
        if let tempCollection = tempCollection {
            for pokemon in tempCollection {
                pokemonArr[pokemon.id].setGeneration(pokemon.generationNumber)
            }
        } else {
            print ("Error instantiating collection for initGenerations")
        }
    }
    
    func initEvolutions() {
        let tempCollection = APIHandler.readJSONFile(fileName: "pokemon_evolutions.json", returnType: PokemonEvolutions.self)
        if let tempCollection = tempCollection {
            for pokemon in tempCollection {
                //check if correct form
                if pokemon.form == pokemonArr[pokemon.pokemonID].baseForm {
                    //copy evolution info over to evolvesInto
                    pokemonArr[pokemon.pokemonID].evolvesInto = pokemon.evolutions
                    //copy evolution info over to evolvesFrom
                    for pokemon2 in pokemon.evolutions {
                        if pokemon2.form == pokemonArr[pokemon2.pokemonID].baseForm {
                            pokemonArr[pokemon2.pokemonID].evolvesFrom.append(pokemon2)
                        }
                    }
                }
                
            }
        } else {
            print ("Error instantiating collection for initEvolutions ")
        }
    }
    func initMegaEvolutions() {
        let tempCollection = APIHandler.readJSONFile(fileName: "mega_pokemon.json", returnType: MegaPokemons.self)
        if let tempCollection = tempCollection {
            for megaPokemon in tempCollection {
                pokemonArr[megaPokemon.pokemonID].addMegaEvolution(megaPokemon)
            }
        } else {
            print ("Error instantiating collection for initMegaEvolutions ")
        }
    }
    func initIsBaby() {
        let tempCollection = APIHandler.readJSONFile(fileName: "baby_pokemon.json", returnType: BabyPokemon.self)
        if let tempCollection = tempCollection {
            for babyPokemon in tempCollection {
                pokemonArr[babyPokemon.id].setIsBaby(true)
            }
        } else {
            print ("Error instantiating collection for initIsBaby ")
        }
    }
    func initShiny() {
        let tempCollection = APIHandler.readJSONFile(fileName: "shiny_pokemon.json", returnType: ShinyPokemons.self)
        if let tempCollection = tempCollection {
            for (key, value) in tempCollection {
                pokemonArr[key].setShiny(value)
            }
        } else {
            print ("Error instantiating collection for initShiny ")
        }
    }
    func initPokemonTyping() {
        let tempCollection = APIHandler.readJSONFile(fileName: "pokemon_types.json", returnType: PokemonTyping.self)
        if let tempCollection = tempCollection {
            for pokemon in tempCollection {
                if pokemon.form == "Normal" && pokemon.pokemonID < pokemonArr.count {
                    pokemonArr[pokemon.pokemonID].setTyping(pokemon.type)
                    pokemonArr[pokemon.pokemonID].initTypingColor()
                } else if pokemon.form == "Normal" {
                    print("initPokemonTyping: Error inserting Pokemon id: \(pokemon.pokemonID), name: \(pokemon.pokemonName)")
                }
            }
        } else {
            print ("Error instantiating collection for initPokemonTyping ")
        }
    }
    func initMaxCP() {
        let tempCollection = APIHandler.readJSONFile(fileName: "pokemon_max_cp.json", returnType: MaxCP.self)
        if let tempCollection = tempCollection {
            for pokemon in tempCollection {
                if pokemon.pokemonID < pokemonArr.count {
                    pokemonArr[pokemon.pokemonID].setMaxCP(pokemon.maxCp)
                } else {
                    print("initMaxCP: Error inserting Pokemon id: \(pokemon.pokemonID), name: \(pokemon.pokemonName)")
                }
            }
        } else {
            print ("Error instantiating collection for initMaxCP ")
        }
    }
    

    
}
