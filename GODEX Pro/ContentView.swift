//
//  ContentView.swift
//  GODEX Pro
//
//  Created by Tyler Vergin on 5/10/23.
//

import SwiftUI



enum Page {
    case HomeView
    case PokedexView
    case PokemonView
}
let MyAPIHandler = APIHandler()
var myDex: Pokedex = Pokedex()

struct ContentView: View {
    @EnvironmentObject var pokedex: Pokedex
    @State var currentView: Page = .HomeView
    
    
    init() {
        MyAPIHandler.makeRequests()
        
    }
    
    var body: some View {
        NavigationStack {
//            ZStack {
//
//            LinearGradient(gradient: Gradient(colors: myDex.backGroundGradient), startPoint: .topTrailing, endPoint: .bottomLeading)
//                .ignoresSafeArea()
//
//                if !myDex.isComplete {
//                    LoadingView(currentView: $currentView)
//                } else if currentView == .HomeView {
//                    HomeView(currentView: $currentView)
//                } else if currentView == .PokedexView {
//                    PokedexView(currentView: $currentView)
//                        .background(.clear)
//                }
//            }
            if !myDex.isComplete {
                LoadingView()
            } else {
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

