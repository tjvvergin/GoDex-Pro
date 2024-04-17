//
//  Pokemon.swift
//  GODEX Pro
//
//  Created by Tyler Vergin on 5/10/23.
//

import Foundation
import SwiftUI

class Pokemon: ObservableObject, Identifiable, Equatable {
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return rhs.name == lhs.name
    }
    
    //inherent pokemon stats
    let id: Int
    let name: String
    var generation: Int = 0
    var mainImage: String?
    var mainShinyImage: String?
    var pokemonImages: [String] = []
    var isReleased: Bool = false
    //important details
    var height: Double?
    var weight: Double?
    var attack: Int?
    var defense: Int?
    var stamina: Int?
    var malePercent: Double?
    var femalePercent: Double?
    var baseForm: String = "Normal"
    var maxCP: Int = 0
    var shinyDetails: ShinyPokemon?
    var canBeShiny: Bool {
        if shinyDetails != nil {
            return shinyDetails!.foundEgg || shinyDetails!.foundEvolution || shinyDetails!.foundPhotobomb || shinyDetails!.foundRAID || shinyDetails!.foundWild
        } else {return false}
    }
    var types: [TypeElement] = []
    var colorTypes: [Color] = []
    var evolvesInto: [Evolution] = []
    var evolvesFrom: [Evolution] = []
    @Published var evolutionChain: [[Evolution]] = [[]]
    var evolutionChainPictures: [[String]] = [[]]
    var megaEvolutions: MegaPokemons = []
    var isBaby: Bool = false
    //user details
    @Published var userHasOne: Bool = false
    @Published var userHasShiny: Bool = false
    @Published var userCount: Int = 0
    @Published var userShinyCount: Int = 0
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
        
    }
    
    func getGeneration () -> Int { return self.generation }
    func setGeneration (_ gen: Int) { self.generation = gen }
    
    func getReleased () -> Bool { return self.isReleased }
    func setReleased (_ isReleased: Bool) { self.isReleased = isReleased }
    
    
    func getEvolvesInto () -> [Evolution]? { return self.evolvesInto }
    func setEvolvesInto (_ evolvesInto: [Evolution]) { self.evolvesInto = evolvesInto }
    
    func getMegaEvolutions () -> MegaPokemons { return self.megaEvolutions }
    func addMegaEvolution (_ megaEvolution: MegaPokemon) { self.megaEvolutions.append(megaEvolution) }
    
    func getIsBaby () -> Bool { return self.isBaby }
    func setIsBaby (_ isBaby: Bool) { self.isBaby = isBaby }
    
    func getShiny () -> ShinyPokemon? { return self.shinyDetails }
    func setShiny (_ canBeShiny: ShinyPokemon) { self.shinyDetails = canBeShiny }
    
    func getTyping () -> [TypeElement] { return self.types }
    func setTyping (_ types: [TypeElement]) { self.types = types }
    
    func initEvoChain() {
        var currentPokemon: Pokemon = self
        //iterate through evolvesFrom to find base pokemon
        while !currentPokemon.evolvesFrom.isEmpty {
            for pokemon in currentPokemon.evolvesFrom {
                if pokemon.form == myDex.pokemonArr[pokemon.pokemonID].baseForm {
                    currentPokemon = myDex.pokemonArr[pokemon.pokemonID]
                }
            }
            //currentPokemon is base pokemon
        }
        //iterate upward in linked list adding each evolvesInto into the evo chain
        recurseEvoChain(currentPokemon)
        //instantiate pokemon images
        //        var x = 0, y = 0
        //        for evoArray in evolutionChain {
        //            for evo in evoArray {
        //                evolutionChainPictures.insert(myDex.pokemonArr[pokemon.evolutionChain[x][y]].mainImage ?? "", at: y)
        //            }
        //        }
    }
    
    func recurseEvoChain(_ currentPokemon: Pokemon) {
        if !currentPokemon.evolvesInto.isEmpty {
            self.evolutionChain.append(currentPokemon.evolvesInto)
            
            for evolution in currentPokemon.evolvesInto {
                recurseEvoChain(myDex.pokemonArr[evolution.pokemonID])
            }
        } else {
            return
        }
        
    }
    
    
    func initTypingColor() {
        if types.isEmpty {
            colorTypes.append(.white)
        }
            
        for type in types {
            switch type {
            case .bug: colorTypes.append(Color("LightGreen"))
            case .dark: colorTypes.append(.black)
            case .dragon: colorTypes.append(.blue)
            case .electric: colorTypes.append(.yellow)
            case .fairy: colorTypes.append(.pink)
            case .fighting: colorTypes.append(.red)
            case .fire: colorTypes.append(.red)
            case .flying: colorTypes.append(Color("BabyBlue"))
            case .ghost: colorTypes.append(Color("DarkPurple"))
            case .grass: colorTypes.append(.green)
            case .ground: colorTypes.append(.brown)
            case .ice: colorTypes.append(Color("IceBlue"))
            case .normal: colorTypes.append(.gray)
            case .poison: colorTypes.append(Color("PoisonPurple"))
            case .psychic: colorTypes.append(Color("PsychicPink"))
            case .rock: colorTypes.append(Color("RockTan"))
            case .steel: colorTypes.append(Color("SteelGrey"))
            case .water: colorTypes.append(.blue)
            }
        }
    }
    
    func getMaxCP () -> Int { return self.maxCP }
    func setMaxCP (_ maxCP: Int) { self.maxCP = maxCP }
    
    func formatPokemonImages(with imageNames: [String]) {
        self.pokemonImages.reserveCapacity(imageNames.count + 2)
        
        
        if let tempImage = self.mainImage {
            pokemonImages.append(tempImage)
        }
        if let tempShinyImage = self.mainShinyImage {
            pokemonImages.append(tempShinyImage)
        }
        
        for imageName in imageNames {
            if imageName != self.mainImage && imageName != self.mainShinyImage {
                pokemonImages.append(imageName)
            }
        }
        
    }
    
    func initPokemonImages() {
        var formattedName = name
        switch formattedName {
        case "Nidoran♀": formattedName = "nidoran-f"
        case "Nidoran♂": formattedName = "nidoran-m"
        case "Farfetch’d": formattedName = "farfetchd"
        case "Mr. Mime": formattedName = "mr-mime"
        case "Mime Jr.": formattedName = "mime-jr"
        case "Tapu Koko": formattedName = "tapu-koko"
        case "Tapu Lele": formattedName = "tapu-lele"
        case "Tapu Bulu": formattedName = "tapu-bulu"
        case "Tapu Fini": formattedName = "tapu-fini"
        case "Sirfetch’d": formattedName = "sirfetchd"
        case "Mr. Rime": formattedName = "mr-rime"
        default: formattedName = formattedName.lowercased()
        }
        
        if let imageNames = APIHandler.getPokemonImageNames() {
            //initialize images array for output
            var images: [String] = []
            for imageName in imageNames {
                //cast to nsstring to check if prefix of file meets expectations
                let fileName = (imageName as NSString).lastPathComponent
                if fileName.hasPrefix(formattedName) || fileName.hasPrefix("shiny-\(formattedName)") {
                    let image = imageName
                    if fileName == ("\(formattedName).png") {
                        //check if it is the main image
                        mainImage = image.replacingOccurrences(of: ".png", with: "")
                    } else if fileName == ("shiny-\(formattedName).png") {
                        //check if it is the main image of the shiny variant
                        mainShinyImage = image.replacingOccurrences(of: ".png", with: "")
                    } else if fileName.hasPrefix("\(formattedName)-") || fileName.hasPrefix("shiny-\(formattedName)-") {
                        //remove .png from image name
                        images.append(image.replacingOccurrences(of: ".png", with: ""))
                    }
                }
            }
            
            if (mainImage == nil) {
                backupMainImageFinder()
                if images.isEmpty && mainImage == nil {
                    print("No images found for \(name)")
                } else if (mainImage == nil) {
                    print("No main images found for \(name)")
                }
            }
            formatPokemonImages(with: images)
        }
    }
    
    func backupMainImageFinder () {
    var imageName: String = ""
        switch name {
        case "Unown": imageName = "unown-a"
        case "Spinda": imageName = "spinda-01"
        case "Deoxys": imageName = "deoxys-normal"
        case "Burmy": imageName = "burmy-plant"
        case "Wormadam": imageName = "wormadam-plant"
        case "Cherrim": imageName = "cherrim-sunshine"
        case "Shellos": imageName = "shellos-east"
        case "Gastrodon": imageName = "gastrodon-east"
        case "Giratina": imageName = "giratina-altered"
        case "Shaymin": imageName = "shaymin-sky"
        case "Basculin": imageName = "basculin-blue-striped"
        case "Darmanitan": imageName = "darmanitan-standard"
        case "Deerling": imageName = "deerling-summer"
        case "Sawsbuck": imageName = "sawsbuck-summer"
        case "Tornadus": imageName = "tornadus-incarnate"
        case "Thundurus": imageName = "thundurus-incarnate"
        case "Landorus": imageName = "landorus-incarnate"
        case "Keldeo": imageName = "keldeo-resolute"
        case "Meloetta": imageName = "meloetta-aria"
        case "Vivillon": imageName = "vivillon-elegant"
        case "Flabebe": imageName = "flabebe-yellow"
        case "Floette": imageName = "floette-yellow"
        case "Florges": imageName = "florges-yellow"
        case "Furfrou": imageName = "furfrou-natural"
        case "Meowstic": imageName = "meowstic-female"
        case "Pumpkaboo": imageName = "pumpkaboo-super"
        case "Gourgeist": imageName = "gourgeist-super"
        case "Hoopa": imageName = "hoopa-confined"
        case "Oricorio": imageName = "oricorio-pom-pom"
        case "Lycanroc": imageName = "lycanroc-midnight"
        case "Zacian": imageName = "zacian-hero"
        case "Zamazenta": imageName = "zamazenta-hero"
        default: break
        }
        if imageName != "" {
            mainImage = imageName
        }
        mainShinyImage = "shiny-\(imageName)"
    }
    
    
}
