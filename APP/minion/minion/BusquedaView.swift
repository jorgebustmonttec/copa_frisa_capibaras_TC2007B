//
//  BusquedaView.swift
//  App
//
//  Created by Miguel Ponce on 16/05/24.
//
// Definición del enum SearchResult
import Foundation

enum SearchResult {
    case jugador(Jugador)
    case partido(Partido)
}

// Extensión para hacerlo Identifiable
extension SearchResult: Identifiable {
    var id: UUID {
        switch self {
        case .jugador(let jugador):
            return jugador.id
        case .partido(let partido):
            return partido.id
        }
    }
}


// Implementación de BusquedaView
import SwiftUI

struct BusquedaView: View {
    @State private var searchText = ""

    let jugadores: [Jugador] = [
        Jugador(nombre: "Jose", posicion: "Delantero", numeroGoles: 5, tarjetas: 1),
        Jugador(nombre: "Juan Luis", posicion: "Mediocampista", numeroGoles: 3, tarjetas: 0),
        Jugador(nombre: "Pedro", posicion: "Defensa", numeroGoles: 1, tarjetas: 2),
        Jugador(nombre: "Alonso", posicion: "Portero", numeroGoles: 0, tarjetas: 1)
    ]
    
    let partidosPasados: [Partido] = [
        Partido(equipoContrario: "Equipo E vs Equipo F", fecha: Date().addingTimeInterval(-86400 * 2), resultado: "4-0", detalles: "Victoria para Equipo E."),
        Partido(equipoContrario: "Equipo G vs Equipo H", fecha: Date().addingTimeInterval(-86400 * 5), resultado: "3-3", detalles: "Empate entre Equipo G y Equipo H.")
    ]
    
    let partidos: [Partido] = [
        Partido(equipoContrario: "Equipo A vs Equipo B", fecha: Date(), resultado: "2-2", detalles: "Empate entre Equipo A y Equipo B."),
        Partido(equipoContrario: "Equipo C vs Equipo D", fecha: Date().addingTimeInterval(86400 * 2), resultado: "3-1", detalles: "Victoria para Equipo D.")
    ]

    @State private var selectedPartido: Partido?

    var searchResults: [SearchResult] {
        var results = [SearchResult]()
        results += jugadores.filter { $0.nombre.localizedCaseInsensitiveContains(searchText) || searchText.isEmpty }.map { SearchResult.jugador($0) }
        results += partidosPasados.filter { $0.equipoContrario.localizedCaseInsensitiveContains(searchText) || searchText.isEmpty }.map { SearchResult.partido($0) }
        results += partidos.filter { $0.equipoContrario.localizedCaseInsensitiveContains(searchText) || searchText.isEmpty }.map { SearchResult.partido($0) }
        return results
    }

    var body: some View {
        NavigationView {
            List(searchResults) { result in
                switch result {
                case .jugador(let jugador):
                    NavigationLink(destination: JugadorView(jugador: jugador)) {
                        Text(jugador.nombre)
                    }
                case .partido(let partido):
                    NavigationLink(destination: PartidoView(partido: partido)) {
                        VStack(alignment: .leading) {
                            Text(partido.equipoContrario)
                            Text("Fecha: \(partido.fecha, formatter: dateFormatter)").font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Búsqueda")
            .searchable(text: $searchText)
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
}

struct BusquedaView_Previews: PreviewProvider {
    static var previews: some View {
        BusquedaView()
    }
}
#Preview {
    BusquedaView()
}



