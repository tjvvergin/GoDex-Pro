//
//  SettingsView.swift
//  GODEX Pro
//
//  Created by Tyler Vergin on 6/3/23.
//

import SwiftUI

struct NewsView: View {
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(myDex.communityDays) {x in
                        communityDayCardView(day: x)
                            .ignoresSafeArea(edges: [.leading, .trailing])
                    }
                }
            }.padding()
                
            .frame(maxHeight: 200)
            NavigationLink(destination: TwitterView()
                .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
                .navigationBarTitle(Text("Pokemon GO Twitter"))
            ) {
                Text("Open Twitter")
                    .padding()
            }
            Spacer()
        }
        .background(Color(.secondarySystemFill))
        .navigationTitle("Pokemon News")
    }
}

struct communityDayCardView: View {
    var day: CommunityDay
    var body: some View {
        
        VStack {
            HStack {
                ForEach(day.boostedPokemon.reversed()) { pokemonName in
                    VStack {
                        Image(myDex.getPokemon(name: pokemonName)?.mainImage ?? "")
                            .resizable()
                            .scaledToFit()
                            .minimumScaleFactor(0.1)
                        Text("\(pokemonName)")
                            .scaledToFit()
                            .minimumScaleFactor(0.1)
                    }
                    
                    
                }
                
            }
            Text("Date: \(day.startDate)")
                .scaledToFit()
                .minimumScaleFactor(0.1)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .foregroundColor(Color(.systemBackground))
        )
        
    }
}

extension String: Identifiable {
    public var id: String { self }
    
    
}

