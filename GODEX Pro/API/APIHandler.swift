//
//  MyAPIHandler.swift
//  GODEX Pro
//
//  Created by Tyler Vergin on 5/10/23.
//
var APICallsMade = 0
let APICallsNeeded = 13

import Foundation
class APIHandler {
    
    
    
    //stores the filename requested into the documents folder to be read later
    static func storeAPIRequest(fileName: String) {
        let url = URL(string: "https://pogoapi.net/api/v1/" + fileName)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            //debugPrint(data)
            //debugPrint(response)
            let fileManager = FileManager.default
            let documentDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            debugPrint("Writing to: \(fileURL)")
            do {
                try data.write(to: fileURL)
                debugPrint("Successful writing to: \(fileName)")
                APICallsMade += 1
                if APICallsMade == APICallsNeeded {
                    myDex.initPokedexWithValues()
                }
            } catch {
                debugPrint("Data writing failed with error: \(error.localizedDescription)")
                APICallsMade += 1
                if APICallsMade == APICallsNeeded {
                    myDex.initPokedexWithValues()
                    
                }
            }
        }
        
        task.resume()
    }
    
    
    /*
     //reads the json file from the documents folder into the specified return type
     static func readJSONFileOld<T: Codable>(fileName: String, type: T.Type, returnType: returnType ) -> (any Collection)? {
     let fileManager = FileManager.default
     let documentDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
     let fileURL = documentDirectory.appendingPathComponent(fileName)
     debugPrint("Reading from: ")
     debugPrint(fileURL)
     
     guard let data = try? Data(contentsOf: fileURL) else { return nil }
     switch returnType {
     case .Arr:
     do {
     let decoder = JSONDecoder()
     let decodedDict = try decoder.decode([T].self, from: data)
     
     return decodedDict
     } catch {
     print(error)
     }
     case .DictIntArr:
     do {
     let decoder = JSONDecoder()
     let decodedDict = try decoder.decode([Int:[T]].self, from: data)
     
     return decodedDict
     } catch {
     print(error)
     }
     case .DictIntT:
     do {
     let decoder = JSONDecoder()
     let decodedDict = try decoder.decode([Int:T].self, from: data)
     
     return decodedDict
     } catch {
     print(error)
     }
     case .DictStringArr:
     do {
     let decoder = JSONDecoder()
     let decodedDict = try decoder.decode([String:[T]].self, from: data)
     
     return decodedDict
     } catch {
     print(error)
     }
     default:
     print("This return type is not implemented")
     }
     
     
     return nil
     }
     */
    static func readJSONFile<T: Codable>(fileName: String, returnType: T.Type) -> T? {
        let fileManager = FileManager.default
        let documentDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        debugPrint("Reading from: ")
        debugPrint(fileURL)
        
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
    static func getPokemonImageNames() -> [String]? {
        do {
            if let fileURL = Bundle.main.url(forResource: "file_names", withExtension: "json") {
                
                
                let data = try Data(contentsOf: fileURL)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let array = json as? [String] {
                    return array
                } else {
                    print("JSON is not an array of strings")
                    return nil
                }
            }
        } catch {
            print("Error reading JSON file: \(error.localizedDescription)")
            return nil
        }
        return nil
    }
    
    func makeRequests() {
        APIHandler.storeAPIRequest(fileName: "pokemon_names.json")
        APIHandler.storeAPIRequest(fileName: "released_pokemon.json")
        APIHandler.storeAPIRequest(fileName: "pokemon_generations.json")
        APIHandler.storeAPIRequest(fileName: "pokemon_evolutions.json")
        APIHandler.storeAPIRequest(fileName: "mega_pokemon.json")
        APIHandler.storeAPIRequest(fileName: "baby_pokemon.json")
        APIHandler.storeAPIRequest(fileName: "shiny_pokemon.json")
        APIHandler.storeAPIRequest(fileName: "pokemon_types.json")
        APIHandler.storeAPIRequest(fileName: "pokemon_max_cp.json")
        APIHandler.storeAPIRequest(fileName: "pokemon_genders.json")
        APIHandler.storeAPIRequest(fileName: "pokemon_stats.json")
        APIHandler.storeAPIRequest(fileName: "pokemon_height_weight_scale.json")
        APIHandler.storeAPIRequest(fileName: "community_days.json")
    }
    
}
