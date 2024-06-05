//
//  Partido.swift
//  App
//
//  Created by Miguel Ponce on 16/05/24.
//

import Foundation

struct Partido: Identifiable {
    var id = UUID()
    var equipoContrario: String
    var fecha: Date
    var resultado: String
    var detalles: String
}
