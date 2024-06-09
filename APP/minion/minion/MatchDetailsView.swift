//
//  MatchDetailsView.swift
//  minion
//
//  Created by Jorge Bustamante on 09/06/24.
//
import SwiftUI

// Define the necessary types
struct APIPartido: Codable, Identifiable {
    var id: Int { id_partido }
    var id_partido: Int
    var equipo_a: Int
    var equipo_b: Int
    var fecha: String
}

struct APIEquipo: Codable {
    var id_equipo: Int
    var nombre_equipo: String
    var escudo: Data?
}

struct APIGoals: Codable {
    var id_partido: Int
    var id_jugador: Int
    var id_equipo: Int
    var tipo_punto: Int
    var tiempo_punto: String
}

struct APIPlayer: Codable, Identifiable {
    var id: Int { id_jugador }
    var id_jugador: Int
    var nombre: String
    var display_name: String
}

struct MatchDetailsView: View {
    var partido: APIPartido
    var equipoA: APIEquipo
    var equipoB: APIEquipo
    var goalsA: Int
    var goalsB: Int

    @State private var jugadoresA: [APIPlayer] = []
    @State private var jugadoresB: [APIPlayer] = []
    @State private var goals: [Int: Int] = [:] // Player ID as key, total goals as value
    @State private var errorMessage: String = ""

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    if let escudoDataA = equipoA.escudo, let escudoA = UIImage(data: escudoDataA) {
                        Image(uiImage: escudoA)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    Text(equipoA.nombre_equipo)
                    Text("\(goalsA) - \(goalsB)")
                    Text(equipoB.nombre_equipo)
                    if let escudoDataB = equipoB.escudo, let escudoB = UIImage(data: escudoDataB) {
                        Image(uiImage: escudoB)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                }
                .padding()

                Text("Fecha: \(formatDate(partido.fecha))")
                    .padding()

                HStack {
                    VStack(alignment: .leading) {
                        Text("Jugadores de \(equipoA.nombre_equipo)")
                            .font(.headline)
                        ForEach(jugadoresA) { jugador in
                            HStack {
                                Text(jugador.display_name)
                                if let goles = goals[jugador.id] {
                                    Text("\(goles) Goles")
                                }
                            }
                        }
                    }
                    .padding()

                    VStack(alignment: .leading) {
                        Text("Jugadores de \(equipoB.nombre_equipo)")
                            .font(.headline)
                        ForEach(jugadoresB) { jugador in
                            HStack {
                                Text(jugador.display_name)
                                if let goles = goals[jugador.id] {
                                    Text("\(goles) Goles")
                                }
                            }
                        }
                    }
                    .padding()
                }

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .onAppear {
                fetchJugadores(by: equipoA.id_equipo, for: "A")
                fetchJugadores(by: equipoB.id_equipo, for: "B")
            }
        }
    }

    private func fetchJugadores(by equipoId: Int, for team: String) {
        let url = "https://localhost:3443/jugadores/equipo/\(equipoId)"
        APIService.shared.fetchJugadores(url: url) { result in
            switch result {
            case .success(let jugadores):
                if team == "A" {
                    self.jugadoresA = jugadores
                    for jugador in jugadores {
                        fetchGoals(for: jugador.id, in: partido.id_partido)
                    }
                } else {
                    self.jugadoresB = jugadores
                    for jugador in jugadores {
                        fetchGoals(for: jugador.id, in: partido.id_partido)
                    }
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func fetchGoals(for jugadorId: Int, in matchId: Int) {
        let url = "https://localhost:3443/puntos/goles/jugador/\(jugadorId)"
        APIService.shared.fetchPlayerGoals(url: url) { result in
            switch result {
            case .success(let goals):
                let matchGoals = goals.filter { $0.id_partido == matchId }
                DispatchQueue.main.async {
                    self.goals[jugadorId] = matchGoals.count
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func formatDate(_ dateStr: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = formatter.date(from: dateStr) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .short
            return displayFormatter.string(from: date)
        }
        return dateStr
    }
}

struct MatchDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailsView(partido: APIPartido(id_partido: 1, equipo_a: 1, equipo_b: 2, fecha: "2024-06-09T07:04:22.000Z"), equipoA: APIEquipo(id_equipo: 1, nombre_equipo: "Equipo A", escudo: nil), equipoB: APIEquipo(id_equipo: 2, nombre_equipo: "Equipo B", escudo: nil), goalsA: 2, goalsB: 3)
    }
}
