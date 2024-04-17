//
//  PokedexView.swift
//  GODEX Pro
//
//  Created by Tyler Vergin on 5/10/23.
//

import SwiftUI

struct PokedexView: View {
//    @Binding var currentView: Page
    @State private var searchText = ""
    @State private var showingAlert = false
    var searchResults: [Pokemon] {
        if searchText.isEmpty {
            return myDex.relevantPokedexArr
        } else {
            let tmp = myDex.searchPokedexArr(query: searchText)
            if tmp.isEmpty {
                DispatchQueue.main.async {
                    showingAlert = true
                }
            }
            return tmp
        }
        
    }
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: myDex.backGroundGradient), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea()
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(searchResults) { pokemon in
                        NavigationLink(destination: PokemonView( pokemon: pokemon)) {
                            PokemonGrid(pokemon: pokemon)
                        }
                        .background(
                            pokemonGradient(pokemon: pokemon)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 10, style: .circular)
                                    .inset(by: 3)
                                )
                        )
                        
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .circular)
                                .inset(by: 3)
                                .stroke(pokemonGradientReversed(pokemon: pokemon), lineWidth: 3)
                            
                        )
                    } //ForEach END
                } //LazyVGrid END
                .toolbarBackground(Color.red, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .navigationTitle("Pokedex")
            } //ScrollView END
        } //ZStack END
        .searchable(text: $searchText, prompt: "Search for a Pokemon")
        .autocorrectionDisabled()
        .alert("Pokemon Not Found", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { searchText = "" }
        }
        
    }
        
        //body END
    
//    old body for list view
//    var body: some View {
//        ZStack {
//            LinearGradient(gradient: Gradient(colors: myDex.backGroundGradient), startPoint: .topTrailing, endPoint: .bottomLeading)
//                .ignoresSafeArea()
//            List(searchResults) { pokemon in
//                NavigationLink(destination: PokemonView( pokemon: pokemon)) {
//                    PokemonRow(pokemon: pokemon)
//                }
//                .listRowBackground(rowGradient(pokemon: pokemon))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10, style: .circular)
//                        .inset(by: -10)
//                        .stroke(overlayGradient(pokemon: pokemon), lineWidth: 3)
//
//                )
//
//            }//List END
//            .listStyle(.automatic)
//            .toolbarBackground(Color.red, for: .navigationBar)
//            .toolbarColorScheme(.dark, for: .navigationBar)
//            .navigationTitle("Pokedex")
//            .scrollContentBackground(.hidden)
//        } //ZStack END
//        .searchable(text: $searchText, prompt: "Search for a Pokemon")
//        .autocorrectionDisabled()
//        .alert("Pokemon Not Found", isPresented: $showingAlert) {
//            Button("OK", role: .cancel) { searchText = "" }
//        }
//
//    }//body END
    
    
    
    }
    
    
    


//for the row of pokemon
struct PokemonGrid: View {
    @ObservedObject var pokemon: Pokemon
    var body: some View {
            VStack {
                Image(pokemon.mainImage!)
                    .resizable()
                    .scaledToFit()
                HStack {
                    VStack {
                        if pokemon.colorTypes.count != 0 && pokemon.colorTypes[0] == .black {
                            Text("#" + String(pokemon.id))
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                                .lineLimit(1)
                            
                            Text(pokemon.name)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .lineLimit(1)
                        } else {
                            Text("#" + String(pokemon.id))
                                .foregroundColor(.black)
                                .fontWeight(.heavy)
                                .lineLimit(1)
                            
                            Text(pokemon.name)
                                .minimumScaleFactor(0.5)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .lineLimit(1)
                        }
                    }
                    Spacer()
                    //pokemon.userHasOne toggle
                    Button {
                        pokemon.userHasOne.toggle()
                    } label: {
                        if !pokemon.userHasOne {
                            if pokemon.colorTypes.count >= 2 && pokemon.colorTypes[1] == .black {
                                Image(systemName: "checkmark.seal")
                                    .foregroundColor(.white)
                            } else {
                                Image(systemName: "checkmark.seal")
                                    .foregroundColor(.black)
                            }
                            
                        } else {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.green)
                        }
                            
                    } //pokemon.userHasOne toggle END
                    //pokemon.userHasShiny toggle
                    Button {
                        pokemon.userHasShiny.toggle()
                    } label: {
                        if !pokemon.userHasShiny {
                            if pokemon.colorTypes.count >= 2 && pokemon.colorTypes[1] == .black {
                                Image(systemName: "sparkle")
                                    .foregroundColor(.white)
                            } else {
                                Image(systemName: "sparkle")
                                    .foregroundColor(.black)
                            }
                            
                            
                        } else {
                            Image(systemName: "sparkles")
                                .symbolRenderingMode(.multicolor)
                        }
                            
                    } //pokemon.userHasShiny toggle END
                }
                .padding([.bottom, .leading, .trailing])
            }
    }
    
    
    
}


//struct PokedexView_Previews: PreviewProvider {
//    static var previews: some View {
//        PokedexView()
//    }
//}
