//
//  APIStructs.swift
//  GODEX Pro
//
//  Created by Tyler Vergin on 5/10/23.
//

import Foundation


// MARK: - APIHashesValue
//fileName: api_hashes.json
struct APIHashesValue: Codable {
    let apiFilename, fullPath, hashMd5, hashSha1: String
    let hashSha256: String

    enum CodingKeys: String, CodingKey {
        case apiFilename = "api_filename"
        case fullPath = "full_path"
        case hashMd5 = "hash_md5"
        case hashSha1 = "hash_sha1"
        case hashSha256 = "hash_sha256"
    }
}

typealias APIHashes = [String: APIHashesValue]

// MARK: - PokemonName
//fileName: pokemon_names.json
struct PokemonName: Codable {
    let id: Int
    let name: String
}

typealias PokemonNames = [Int: PokemonName]

// MARK: - ReleasedPokemon
//fileName: released_pokemon.json
struct ReleasedPokemon: Codable {
    let id: Int
    let name: String
}
typealias ReleasedPokemons = [Int: ReleasedPokemon]

// MARK: - PokemonTypingElement
struct PokemonTypingElement: Codable {
    let form: String
    let pokemonID: Int
    let pokemonName: String
    let type: [TypeElement]

    enum CodingKeys: String, CodingKey {
        case form
        case pokemonID = "pokemon_id"
        case pokemonName = "pokemon_name"
        case type
    }
}

enum TypeElement: String, Codable {
    case bug = "Bug"
    case dark = "Dark"
    case dragon = "Dragon"
    case electric = "Electric"
    case fairy = "Fairy"
    case fighting = "Fighting"
    case fire = "Fire"
    case flying = "Flying"
    case ghost = "Ghost"
    case grass = "Grass"
    case ground = "Ground"
    case ice = "Ice"
    case normal = "Normal"
    case poison = "Poison"
    case psychic = "Psychic"
    case rock = "Rock"
    case steel = "Steel"
    case water = "Water"
}

typealias PokemonTyping = [PokemonTypingElement]



// MARK: - CommunityDay
struct CommunityDay: Codable, Identifiable {
    var id = UUID()
    
    let bonuses: [Bonus]
    let boostedPokemon: [String]
    let communityDayNumber: Int
    let endDate: String
    let eventMoves: [EventMove]
    let startDate: String

    enum CodingKeys: String, CodingKey {
        case bonuses
        case boostedPokemon = "boosted_pokemon"
        case communityDayNumber = "community_day_number"
        case endDate = "end_date"
        case eventMoves = "event_moves"
        case startDate = "start_date"
    }
}

enum Bonus: String, Codable {
    case doubleCatchStardust = "Double Catch Stardust"
    case doubleCatchXP = "Double Catch XP"
    case doubleIncubatorEffectiveness = "Double Incubator effectiveness"
    case doubleXP = "Double XP"
    case quadrupleIncubatorEffectiveness = "Quadruple Incubator effectiveness"
    case tripleCatchStardust = "Triple Catch Stardust"
    case tripleCatchXP = "Triple Catch XP"
}

// MARK: - EventMove
struct EventMove: Codable {
    let move: String
    let moveType: MoveType
    let pokemon: String

    enum CodingKeys: String, CodingKey {
        case move
        case moveType = "move_type"
        case pokemon
    }
}

enum MoveType: String, Codable {
    case charged = "charged"
    case fast = "fast"
}

typealias CommunityDays = [CommunityDay]

// MARK: - ShinyPokemon
//fileName: shiny_pokemon.json
struct ShinyPokemon: Codable {
    let foundEgg, foundEvolution, foundPhotobomb, foundRAID: Bool
    let foundResearch, foundWild: Bool
    let id: Int
    let name: String
    let alolanShiny: Bool?

    enum CodingKeys: String, CodingKey {
        case foundEgg = "found_egg"
        case foundEvolution = "found_evolution"
        case foundPhotobomb = "found_photobomb"
        case foundRAID = "found_raid"
        case foundResearch = "found_research"
        case foundWild = "found_wild"
        case id, name
        case alolanShiny = "alolan_shiny"
    }
}

typealias ShinyPokemons = [Int: ShinyPokemon]

// MARK: - MaxCPElement
struct MaxCPElement: Codable {
    let form: String
    let maxCp, pokemonID: Int
    let pokemonName: String

    enum CodingKeys: String, CodingKey {
        case form
        case maxCp = "max_cp"
        case pokemonID = "pokemon_id"
        case pokemonName = "pokemon_name"
    }
}

typealias MaxCP = [MaxCPElement]
// MARK: - RaidExclusivePokemonsValue
struct RaidExclusivePokemonsValue: Codable {
    let id: Int
    let name: String
    let raidLevel: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case raidLevel = "raid_level"
    }
}

typealias RaidExclusivePokemons = [String: RaidExclusivePokemonsValue]


// MARK: - AlolanPokemonsValue
struct AlolanPokemonsValue: Codable {
    let id: Int
    let name: String
}

typealias AlolanPokemons = [String: AlolanPokemonsValue]


// MARK: - PossibleDittoPokemonsValue
struct PossibleDittoPokemonsValue: Codable {
    let id: Int
    let name: String
}

typealias PossibleDittoPokemons = [String: PossibleDittoPokemonsValue]


// MARK: - PokemonStat
struct PokemonStat: Codable {
    let baseAttack, baseDefense, baseStamina: Int
    let form: String
    let pokemonID: Int
    let pokemonName: String

    enum CodingKeys: String, CodingKey {
        case baseAttack = "base_attack"
        case baseDefense = "base_defense"
        case baseStamina = "base_stamina"
        case form
        case pokemonID = "pokemon_id"
        case pokemonName = "pokemon_name"
    }
}

typealias PokemonStats = [PokemonStat]


// MARK: - PokemonMaxCPElement
//
struct PokemonMaxCPElement: Codable {
    let form: String
    let maxCp, pokemonID: Int
    let pokemonName: String

    enum CodingKeys: String, CodingKey {
        case form
        case maxCp = "max_cp"
        case pokemonID = "pokemon_id"
        case pokemonName = "pokemon_name"
    }
}

typealias PokemonMaxCP = [PokemonMaxCPElement]

// MARK: - PokemonSize
struct PokemonSize: Codable {
    let buddyScale: Double?
    let form: String
    let heightStandardDeviation, modelHeight, modelScale, pokedexHeight: Double
    let pokedexWeight: Double
    let pokemonID: Int
    let pokemonName: String
    let weightStandardDeviation: Double

    enum CodingKeys: String, CodingKey {
        case buddyScale = "buddy_scale"
        case form
        case heightStandardDeviation = "height_standard_deviation"
        case modelHeight = "model_height"
        case modelScale = "model_scale"
        case pokedexHeight = "pokedex_height"
        case pokedexWeight = "pokedex_weight"
        case pokemonID = "pokemon_id"
        case pokemonName = "pokemon_name"
        case weightStandardDeviation = "weight_standard_deviation"
    }
}

typealias PokemonSizes = [PokemonSize]

// MARK: - PokemonGenders
struct PokemonGenders: Codable {
    let the0M1F: [The0M1F]
    let the1M0F: [The1M0F]
    let the1M1F, the1M3F, the1M7F, the3M1F: [The1_M1_F]
    let the7M1F: [The1_M1_F]
    let genderless: [Genderless]

    enum CodingKeys: String, CodingKey {
        case the0M1F = "0M_1F"
        case the1M0F = "1M_0F"
        case the1M1F = "1M_1F"
        case the1M3F = "1M_3F"
        case the1M7F = "1M_7F"
        case the3M1F = "3M_1F"
        case the7M1F = "7M_1F"
        case genderless = "Genderless"
    }
}

struct Genderless: Codable {
    let form: String?
    let gender: GenderlessGender
    let pokemonID: Int
    let pokemonName: String

    enum CodingKeys: String, CodingKey {
        case form, gender
        case pokemonID = "pokemon_id"
        case pokemonName = "pokemon_name"
    }
}

struct GenderlessGender: Codable {
    let genderlessPercent: Int

    enum CodingKeys: String, CodingKey {
        case genderlessPercent = "genderless_percent"
    }
}

struct The0M1F: Codable {
    let form: String?
    let gender: The0M1FGender
    let pokemonID: Int
    let pokemonName: String

    enum CodingKeys: String, CodingKey {
        case form, gender
        case pokemonID = "pokemon_id"
        case pokemonName = "pokemon_name"
    }
}

struct The0M1FGender: Codable {
    let femalePercent: Int

    enum CodingKeys: String, CodingKey {
        case femalePercent = "female_percent"
    }
}

struct The1M0F: Codable {
    let form: String?
    let gender: The1M0FGender
    let pokemonID: Int
    let pokemonName: String

    enum CodingKeys: String, CodingKey {
        case form, gender
        case pokemonID = "pokemon_id"
        case pokemonName = "pokemon_name"
    }
}

struct The1M0FGender: Codable {
    let malePercent: Int

    enum CodingKeys: String, CodingKey {
        case malePercent = "male_percent"
    }
}

struct The1_M1_F: Codable {
    let gender: The1M1FGender
    let pokemonID: Int
    let pokemonName: String
    let form: String?

    enum CodingKeys: String, CodingKey {
        case gender
        case pokemonID = "pokemon_id"
        case pokemonName = "pokemon_name"
        case form
    }
}

struct The1M1FGender: Codable {
    let femalePercent, malePercent: Double

    enum CodingKeys: String, CodingKey {
        case femalePercent = "female_percent"
        case malePercent = "male_percent"
    }
}

// MARK: - PokemonCandyToEvolveElement
struct PokemonCandyToEvolveElement: Codable {
    let form: String
    let maxCp, pokemonID: Int
    let pokemonName: String

    enum CodingKeys: String, CodingKey {
        case form
        case maxCp = "max_cp"
        case pokemonID = "pokemon_id"
        case pokemonName = "pokemon_name"
    }
}

typealias PokemonCandyToEvolve = [PokemonCandyToEvolveElement]


// MARK: - TypeEffectiveness
typealias TypeEffectiveness = [String: [String: Double]]


//MARK: - PlayerXPRequirements
//fileName: player_xp_requirements.json
typealias PlayerXPRequirements = [String: Int]



// MARK: - PokemonGenerations
//fileName: pokemon_generations.json
struct PokemonGenerations: Codable, Sequence {
    let generation1, generation2, generation3, generation4: [Generation]
    let generation5, generation6, generation7, generation8: [Generation]

    enum CodingKeys: String, CodingKey {
        case generation1 = "Generation 1"
        case generation2 = "Generation 2"
        case generation3 = "Generation 3"
        case generation4 = "Generation 4"
        case generation5 = "Generation 5"
        case generation6 = "Generation 6"
        case generation7 = "Generation 7"
        case generation8 = "Generation 8"
    }
    
    //function to conform to sequence
    func makeIterator() -> IndexingIterator<Array<Generation>> {
            return allGenerations.makeIterator()
        }
    
    var allGenerations: [Generation] {
            return [generation1,
                    generation2,
                    generation3,
                    generation4,
                    generation5,
                    generation6,
                    generation7,
                    generation8].flatMap { $0 }
        }
}

// interfaces with PokemonGenerations
struct Generation: Codable {
    let generationNumber, id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case generationNumber = "generation_number"
        case id, name
    }
}
// MARK: - BabyPokemonElement
struct BabyPokemonElement: Codable {
    let id: Int
    let name: String
}



typealias BabyPokemon = [BabyPokemonElement]


// MARK: - PokemonEvolution
struct PokemonEvolution: Codable {
    let evolutions: [Evolution]
    let form: String
    let pokemonID: Int
    let pokemonName: String

    enum CodingKeys: String, CodingKey {
        case evolutions, form
        case pokemonID = "pokemon_id"
        case pokemonName = "pokemon_name"
    }
}

//represents pokemon that can be evolved into
struct Evolution: Codable, Identifiable {
    var id = UUID()
    let candyRequired: Int
    let form: String
    let pokemonID: Int
    let pokemonName: String
    let itemRequired: String?
    let noCandyCostIfTraded: Bool?
    let priority: Int?
    let lureRequired: String?
    let buddyDistanceRequired: Int?
    let mustBeBuddyToEvolve, onlyEvolvesInDaytime, onlyEvolvesInNighttime: Bool?
    let genderRequired: GenderRequired?
    let upsideDown: Bool?

    enum CodingKeys: String, CodingKey {
        case candyRequired = "candy_required"
        case form
        case pokemonID = "pokemon_id"
        case pokemonName = "pokemon_name"
        case itemRequired = "item_required"
        case noCandyCostIfTraded = "no_candy_cost_if_traded"
        case priority
        case lureRequired = "lure_required"
        case buddyDistanceRequired = "buddy_distance_required"
        case mustBeBuddyToEvolve = "must_be_buddy_to_evolve"
        case onlyEvolvesInDaytime = "only_evolves_in_daytime"
        case onlyEvolvesInNighttime = "only_evolves_in_nighttime"
        case genderRequired = "gender_required"
        case upsideDown = "upside_down"
    }
}

enum GenderRequired: String, Codable {
    case female = "Female"
    case male = "Male"
}

typealias PokemonEvolutions = [PokemonEvolution]



// MARK: - MegaPokemon
struct MegaPokemon: Codable {
    let firstTimeMegaEnergyRequired: Int
    let form: Form
    let megaEnergyRequired: Int
    let megaName: String
    let pokemonID: Int
    let pokemonName: String
    let stats: Stats
    let type: [String]

    enum CodingKeys: String, CodingKey {
        case firstTimeMegaEnergyRequired = "first_time_mega_energy_required"
        case form
        case megaEnergyRequired = "mega_energy_required"
        case megaName = "mega_name"
        case pokemonID = "pokemon_id"
        case pokemonName = "pokemon_name"
        case stats, type
    }
}

enum Form: String, Codable {
    case normal = "Normal"
    case x = "X"
    case y = "Y"
}

// MARK: - Stats
struct Stats: Codable {
    let baseAttack, baseDefense, baseStamina: Int

    enum CodingKeys: String, CodingKey {
        case baseAttack = "base_attack"
        case baseDefense = "base_defense"
        case baseStamina = "base_stamina"
    }
}

typealias MegaPokemons = [MegaPokemon]

enum Rarity: String, Codable {
    case legendary = "Legendary"
    case mythic = "Mythic"
    case standard = "Standard"
    case ultraBeast = "Ultra beast"
}


