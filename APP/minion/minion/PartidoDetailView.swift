//
//  PartidoDetailView.swift
//  minion
//
//  Created by Jorge Bustamante on 10/06/24.
//
import SwiftUI

struct PartidoDetailView: View {
    @State private var equipoA: APIEquipo?
    @State private var equipoB: APIEquipo?
    @State private var equipoALogo: Image?
    @State private var equipoBLogo: Image?
    @State private var jugadoresEquipoA: [APIJugadorEquipo] = []
    @State private var jugadoresEquipoB: [APIJugadorEquipo] = []
    @State private var goles: [Int: Int] = [:] // [playerId: goals]
    @State private var errorMessage: String = ""
    
    var partido: APIPartido
    
    var body: some View {
        VStack {
            if let equipoA = equipoA, let equipoB = equipoB {
                VStack {
                    HStack {
                        VStack {
                            if let equipoALogo = equipoALogo {
                                NavigationLink(destination: EquipoDetailView(equipoId: equipoA.id_equipo)) {
                                    equipoALogo
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                }
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                            }
                            NavigationLink(destination: EquipoDetailView(equipoId: equipoA.id_equipo)) {
                                Text(equipoA.nombre_equipo)
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 100)
                            }
                        }
                        Spacer()
                        VStack {
                            Text("\(goles[partido.equipo_a] ?? 0) - \(goles[partido.equipo_b] ?? 0)")
                                .font(.largeTitle)
                                .bold()
                        }
                        Spacer()
                        VStack {
                            if let equipoBLogo = equipoBLogo {
                                NavigationLink(destination: EquipoDetailView(equipoId: equipoB.id_equipo)) {
                                    equipoBLogo
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                }
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                            }
                            NavigationLink(destination: EquipoDetailView(equipoId: equipoB.id_equipo)) {
                                Text(equipoB.nombre_equipo)
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 100)
                            }
                        }
                    }
                    .padding()
                    Text(formatDate(partido.fecha))
                        .font(.subheadline)
                        .padding(.top, 10)
                    
                    Divider()
                        .padding(.vertical, 20)
                    
                    ScrollView {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text("Jugadores")
                                    .font(.headline)
                                    .padding(.bottom, 5)
                                ForEach(sortedPlayers(jugadores: jugadoresEquipoA), id: \.id_jugador) { jugador in
                                    NavigationLink(destination: JugadorPerfilView(userId: jugador.id_usuario)) {
                                        HStack {
                                            Text(jugador.nombre)
                                                .font(.body)
                                            Spacer()
                                            if let golesJugador = goles[jugador.id_jugador], golesJugador > 0 {
                                                Text("\(golesJugador)")
                                                    .font(.subheadline)
                                            }
                                        }
                                        .padding()
                                        .background(Color(.secondarySystemBackground))
                                        .cornerRadius(10)
                                        .padding(.vertical, 5)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            VStack(alignment: .trailing) {
                                Text("Jugadores")
                                    .font(.headline)
                                    .padding(.bottom, 5)
                                ForEach(sortedPlayers(jugadores: jugadoresEquipoB), id: \.id_jugador) { jugador in
                                    NavigationLink(destination: JugadorPerfilView(userId: jugador.id_usuario)) {
                                        HStack {
                                            if let golesJugador = goles[jugador.id_jugador], golesJugador > 0 {
                                                Text("\(golesJugador)")
                                                    .font(.subheadline)
                                            }
                                            Spacer()
                                            Text(jugador.nombre)
                                                .font(.body)
                                        }
                                        .padding()
                                        .background(Color(.secondarySystemBackground))
                                        .cornerRadius(10)
                                        .padding(.vertical, 5)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding()
            } else if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                ProgressView("Cargando datos...")
                    .padding()
            }
        }
        .onAppear {
            fetchEquipoData()
            fetchJugadores()
        }
        .navigationTitle("Detalles del Partido")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func fetchEquipoData() {
        fetchEquipo(id: partido.equipo_a) { equipo in
            self.equipoA = equipo
            self.fetchEquipoShield(id: equipo.id_equipo, isEquipoA: true)
        }
        fetchEquipo(id: partido.equipo_b) { equipo in
            self.equipoB = equipo
            self.fetchEquipoShield(id: equipo.id_equipo, isEquipoA: false)
        }
    }
    
    private func fetchEquipo(id: Int, completion: @escaping (APIEquipo) -> Void) {
        let url = "https://localhost:3443/equipos/single/\(id)"
        APIService.shared.fetchEquipo(url: url) { result in
            switch result {
            case .success(let equipo):
                print("Equipo fetched: \(equipo.nombre_equipo)")
                completion(equipo)
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print("Failed to fetch equipo \(id): \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchEquipoShield(id: Int, isEquipoA: Bool) {
        let url = "https://localhost:3443/equipos/single/\(id)/escudo"
        APIService.shared.fetchEquipoShield(url: url) { result in
            switch result {
            case .success(let data):
                if let uiImage = UIImage(data: data) {
                    let image = Image(uiImage: uiImage)
                    if isEquipoA {
                        self.equipoALogo = image
                    } else {
                        self.equipoBLogo = image
                    }
                }
                print("Fetched shield for team \(id)")
            case .failure(let error):
                print("Failed to fetch team \(id) shield: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchJugadores() {
        fetchJugadores(equipoId: partido.equipo_a) { jugadores in
            self.jugadoresEquipoA = jugadores
            jugadores.forEach { jugador in
                self.fetchGoals(for: jugador.id_jugador)
            }
        }
        fetchJugadores(equipoId: partido.equipo_b) { jugadores in
            self.jugadoresEquipoB = jugadores
            jugadores.forEach { jugador in
                self.fetchGoals(for: jugador.id_jugador)
            }
        }
    }
    
    private func fetchJugadores(equipoId: Int, completion: @escaping ([APIJugadorEquipo]) -> Void) {
        let url = "https://localhost:3443/jugadores/equipo/\(equipoId)"
        APIService.shared.fetchJugadores(url: url) { result in
            switch result {
            case .success(let jugadores):
                print("Jugadores fetched for team \(equipoId): \(jugadores.map { $0.nombre })")
                completion(jugadores)
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print("Failed to fetch jugadores for team \(equipoId): \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchGoals(for playerId: Int) {
        let url = "https://localhost:3443/puntos/goles/jugador/\(playerId)/partido/\(partido.id_partido)/total"
        APIService.shared.fetchTotalGoals(url: url) { result in
            switch result {
            case .success(let goals):
                DispatchQueue.main.async {
                    self.goles[playerId] = goals.total_goals
                    print("Fetched goals for player \(playerId) in match \(partido.id_partido): \(goals.total_goals)")
                    self.updateMatchScore()
                }
            case .failure(let error):
                print("Failed to fetch goals for player \(playerId) in match \(partido.id_partido): \(error.localizedDescription)")
            }
        }
    }
    
    private func updateMatchScore() {
        let totalGoalsA = jugadoresEquipoA.reduce(0) { $0 + (goles[$1.id_jugador] ?? 0) }
        let totalGoalsB = jugadoresEquipoB.reduce(0) { $0 + (goles[$1.id_jugador] ?? 0) }
        self.goles[partido.equipo_a] = totalGoalsA
        self.goles[partido.equipo_b] = totalGoalsB
        print("Updated match score: \(totalGoalsA) - \(totalGoalsB)")
    }
    
    private func sortedPlayers(jugadores: [APIJugadorEquipo]) -> [APIJugadorEquipo] {
        return jugadores.sorted {
            (goles[$0.id_jugador] ?? 0) > (goles[$1.id_jugador] ?? 0)
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

struct PartidoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PartidoDetailView(partido: APIPartido(id_partido: 1, equipo_a: 1, equipo_b: 2, fecha: "2024-06-02T06:00:00.000Z", ganador: nil))
    }
}
