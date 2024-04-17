//
//  HomeView.swift
//  GODEX Pro
//
//  Created by Tyler Vergin on 5/10/23.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: myDex.backGroundGradient), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    NavigationLink(destination: NewsView()) {
                        Image(systemName: "newspaper")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .padding()
                    }
                }
                Spacer()
                Text("Welcome to your Pokedex!")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                NavigationLink(destination: PokedexView()) {
                    
                    VStack {
                        Image("pokeball")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 200)
                        Text("To Pokedex")
                            .buttonStyle(.borderedProminent)
                    }
                }
                Spacer()
                
            }
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
