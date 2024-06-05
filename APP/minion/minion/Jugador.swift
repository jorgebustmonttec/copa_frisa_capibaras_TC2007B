//
//  Jugador.swift
//  App
//
//  Created by Miguel Ponce on 16/05/24.
//

import Foundation

struct Jugador: Identifiable {
    let id = UUID()
    var nombre: String
    var posicion: String
    var numeroGoles: Int
    var tarjetas: Int
}
