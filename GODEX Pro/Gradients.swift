//
//  Gradients.swift
//  GODEX Pro
//
//  Created by Tyler Vergin on 5/22/23.
//

import Foundation
import SwiftUI

func pokemonGradientReversed(pokemon: Pokemon) -> LinearGradient {
    if pokemon.colorTypes.count == 0 {
        return LinearGradient(gradient: Gradient(colors: [.white, .white]), startPoint: .leading, endPoint: .trailing)
    } else if pokemon.colorTypes.count == 1  {
        return LinearGradient(gradient: Gradient(colors: [.white, pokemon.colorTypes[0]]), startPoint: .leading, endPoint: .trailing)
    } else if pokemon.colorTypes[0] != pokemon.colorTypes[1] {
        return LinearGradient(gradient: Gradient(colors: [pokemon.colorTypes[1], pokemon.colorTypes[0]]), startPoint: .leading, endPoint: .trailing)
    } else {
        return LinearGradient(gradient: Gradient(colors: [.white, pokemon.colorTypes[0]]), startPoint: .leading, endPoint: .trailing)
    }
}

func pokemonGradient(pokemon: Pokemon) -> LinearGradient {
    if pokemon.colorTypes.count == 0 {
        return LinearGradient(gradient: Gradient(colors: [.white, .white]), startPoint: .leading, endPoint: .trailing)
    } else if pokemon.colorTypes.count == 1 {
        return LinearGradient(gradient: Gradient(colors: [pokemon.colorTypes[0], .white]), startPoint: .leading, endPoint: .trailing)
    } else if pokemon.colorTypes[0] != pokemon.colorTypes[1] {
        return LinearGradient(gradient: Gradient(colors: [pokemon.colorTypes[0], pokemon.colorTypes[1]]), startPoint: .leading, endPoint: .trailing)
    } else {
        return LinearGradient(gradient: Gradient(colors: [pokemon.colorTypes[0], .white]), startPoint: .leading, endPoint: .trailing)
    }
}
