//
//  PokemonView.swift
//  GODEX Pro
//
//  Created by Tyler Vergin on 5/10/23.
//

import SwiftUI
import Charts

struct PokemonView: View {
    @ObservedObject var pokemon: Pokemon
    @State var userHasOne: Bool = false
    @State var currentPicture: String = ""
    
    let percentFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }()
    
    let insetValue: CGFloat = 3
    let cornerRadius: CGFloat = 10
    let lineWidth: CGFloat = 3
    
    var body: some View {
        ScrollView {
            displayPokemonImagesCarousel
                .frame(minHeight: 260)
            VStack {
                displayElements
                infoCard
                statsCard
            } //VStack END
            .padding([.leading, .trailing, .bottom])
            Spacer()
        } //ScrollView END
        .navigationTitle("#\(pokemon.id): \(pokemon.name) ")
        .background(Color(.secondarySystemFill))
        
    }
    
    

    //MARK: statsCard
    var statsCard: some View {
        VStack {
            Chart {
                //stamina
                BarMark (
                    x: .value("Stamina", pokemon.stamina ?? 0),
                    y: .value("Stamina", "Stamina")
                )
                .foregroundStyle(Color(.green))
                BarMark (
                    x: .value("Average", myDex.averageStamina),
                    y: .value("Avg. Stamina", "Average Stamina")
                )
                .foregroundStyle(Color(.brown))
                
                //defense
                BarMark (
                    x: .value("Defense", pokemon.defense ?? 0),
                    y: .value("Defense", "Defense")
                )
                .foregroundStyle(Color(.blue))
                BarMark (
                    x: .value("Average", myDex.averageDefense),
                    y: .value("Avg. Defense", "Average Defense")
                    
                )
                .foregroundStyle(Color(.brown))
                
                //attack
                BarMark (
                    x: .value("Attack", pokemon.attack ?? 0),
                    y: .value("Attack", "Attack")
                )
                .foregroundStyle(Color(.red))
                BarMark (
                    x: .value("Average", myDex.averageAttack),
                    y: .value("Avg. Attack", "Average Attack")
                )
                .foregroundStyle(Color(.brown))
                
            }
            .padding()
            
            

        }
        .frame(minHeight: 200)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .foregroundColor(Color(.systemBackground))
        )
    }
    
    //MARK: infoCard
    var infoCard: some View {
        HStack(alignment: .center) {
            VStack {
                Image(systemName: "scalemass")
                Text(String(format: "%.2fkgs", pokemon.weight ?? 0))
                    .lineLimit(1)
            }
            .padding()
            Divider()
            displayGenderChart
                .frame(maxHeight: 60)
                .padding()
            Divider()
            //height goes here
            VStack {
                Image(systemName: "ruler")
                Text(String(format: "%.2fm", pokemon.height ?? 0))
                    .lineLimit(1)
            }
            .padding()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .foregroundColor(Color(.systemBackground))
        )
    }
    
    //MARK: displayPokemonImages
    var displayPokemonImagesCarousel: some View {
            TabView(content: {
                ForEach(0..<pokemon.pokemonImages.count, id: \.self) { imageNum in
                    Image(pokemon.pokemonImages[imageNum])
                        .padding([.bottom])
                }
            })
            .tabViewStyle(PageTabViewStyle())
            .background(
            pokemonGradient(pokemon: pokemon)
                .clipShape(
                    RoundedRectangle(cornerRadius: cornerRadius, style: .circular)
                    .inset(by: insetValue)
                )
            )
            .overlay (
                RoundedRectangle(cornerRadius: cornerRadius)
                    .inset(by: insetValue)
                    .strokeBorder(pokemonGradientReversed(pokemon: pokemon), lineWidth: lineWidth)
            )
            
            
        }
    

    //MARK: displayGenderChart
    var displayGenderChart: some View {
        HStack {
            if pokemon.femalePercent == 0 && pokemon.malePercent == 0 {
                Text("⚲ Genderless")
                    .lineLimit(1)
                    .scaledToFit()
                    .minimumScaleFactor(0.10)
                Pie(slices: [
                    (10, .gray)
                ])
            } else {
                VStack {
                    HStack {
                        Text("♂︎")
                            .foregroundColor(.blue)
                            .scaledToFit()
                            .minimumScaleFactor(0.10)
                        Text(percentFormatter.string(for: pokemon.malePercent ?? 0  ) ?? "-")
                            .scaledToFit()
                            .minimumScaleFactor(0.10)
                    }
                    HStack {
                        Text("♀︎")
                            .foregroundColor(.pink)
                            .scaledToFit()
                            .minimumScaleFactor(0.1)
                        Text(percentFormatter.string(for: pokemon.femalePercent ?? 0  ) ?? "-")
                            .scaledToFit()
                            .minimumScaleFactor(0.1)
                    }
                }
                .frame(minWidth: 50)
                Pie(slices: [
                    (pokemon.femalePercent ?? 0, .pink),
                    (pokemon.malePercent ?? 0, .blue)
                ])
            }
        } //END HStack
        .frame(minWidth: 100)
    }

    //MARK: displayElements
    var displayElements: some View {
        HStack {
            if pokemon.types.count == 0 {
                
            } else if pokemon.types.count == 1 {
                Image("\(pokemon.types[0].rawValue)-tag")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150.0 * 2/3, height: 50.0 * 2/3)
            } else {
                Image("\(pokemon.types[0].rawValue)-tag")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150.0 * 2/3 , height: 50.0 * 2/3)
                Image("\(pokemon.types[1].rawValue)-tag")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150.0 * 2/3, height: 50.0 * 2/3)
            }
            //User collection controls
            Spacer()
            //pokemon.userHasOne toggle
            Button {
                pokemon.userHasOne.toggle()
            } label: {
                if !pokemon.userHasOne {
                    Image(systemName: "checkmark.seal")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50.0 * 2/3 , height: 50.0 * 2/3)
                        .foregroundColor(Color("CompatibleBlack"))
                    
                } else {
                    Image(systemName: "checkmark.seal.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50.0 * 2/3 , height: 50.0 * 2/3)
                        .foregroundColor(.green)
                }
                    
            } //pokemon.userHasOne toggle END
            //pokemon.userHasShiny toggle
            Button {
                pokemon.userHasShiny.toggle() 
            } label: {
                if !pokemon.userHasShiny {
                    Image(systemName: "sparkle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50.0 * 2/3 , height: 50.0 * 2/3)
                        .foregroundColor(Color("CompatibleBlack"))
                    
                    
                } else {
                    Image(systemName: "sparkles")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50.0 * 2/3 , height: 50.0 * 2/3)
                        .symbolRenderingMode(.multicolor)
                }
                    
            } //pokemon.userHasShiny toggle END
        } //HStack END
    }
}

//struct PokemonView_Previews: PreviewProvider {
//    static var previews: some View {
//        PokemonView(pokemon: Pokemon(id: 1, name: "Bulbasaur").)
//    }
//}

