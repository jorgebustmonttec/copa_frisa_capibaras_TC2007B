//
//  BusquedaView.swift
//  App
//
//  Created by Miguel Ponce on 16/05/24.
//
import SwiftUI

struct BusquedaView: View {
    @State private var searchText = ""
    @State private var selectedTab = 0

    var body: some View {
        NavigationView {
            VStack {
                Picker("Select a category", selection: $selectedTab) {
                    Text("Jugadores").tag(0)
                    Text("Equipos").tag(1)
                    Text("Partidos").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                TabView(selection: $selectedTab) {
                    JugadoresView(searchText: searchText)
                        .tabItem { Text("Jugadores") }
                        .tag(0)

                    EquiposView(searchText: searchText)
                        .tabItem { Text("Equipos") }
                        .tag(1)

                    PartidosView(searchText: searchText)
                        .tabItem { Text("Partidos") }
                        .tag(2)
                }
            }
            .navigationTitle("Búsqueda")
            .searchable(text: $searchText)
        }
    }
}

struct JugadoresView: View {
    @State private var jugadores: [APIJugadorEquipo] = []
    @State private var errorMessage: String = ""
    var searchText: String

    var body: some View {
        VStack {
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(filteredJugadores, id: \.id_jugador) { jugador in
                    NavigationLink(destination: JugadorPerfilView(userId: jugador.id_usuario)) {
                        VStack(alignment: .leading) {
                            Text(jugador.nombre)
                                .font(.headline)
                            Text(jugador.nombre_equipo)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .onAppear {
            fetchAllJugadoresData()
        }
    }

    var filteredJugadores: [APIJugadorEquipo] {
        if searchText.isEmpty {
            return jugadores
        } else {
            return jugadores.filter { $0.nombre.localizedCaseInsensitiveContains(searchText) }
        }
    }

    private func fetchAllJugadoresData() {
        let url = "https://localhost:3443/jugadores/small"
        APIService.shared.fetchAllJugadores(url: url) { result in
            switch result {
            case .success(let jugadores):
                self.jugadores = jugadores
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

struct EquiposView: View {
    @State private var equipos: [APIEquipo] = []
    @State private var errorMessage: String = ""
    var searchText: String

    var body: some View {
        VStack {
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(filteredEquipos, id: \.id_equipo) { equipo in
                    NavigationLink(destination: EquipoDetailView(equipoId: equipo.id_equipo)) {
                        VStack(alignment: .leading) {
                            Text(equipo.nombre_equipo)
                                .font(.headline)
                            Text(equipo.escuela)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .onAppear {
            fetchEquiposData()
        }
    }

    var filteredEquipos: [APIEquipo] {
        if searchText.isEmpty {
            return equipos
        } else {
            return equipos.filter { $0.nombre_equipo.localizedCaseInsensitiveContains(searchText) }
        }
    }

    private func fetchEquiposData() {
        APIService.shared.fetchEquipos { result in
            switch result {
            case .success(let equipos):
                self.equipos = equipos
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

struct PartidosView: View {
    @State private var partidos: [APIPartido] = []
    @State private var equipos: [Int: APIEquipo] = [:]
    @State private var errorMessage: String = ""
    var searchText: String

    var body: some View {
        VStack {
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(filteredPartidos, id: \.id_partido) { partido in
                    NavigationLink(destination: PartidoDetailView(partido: partido)) {
                        VStack(alignment: .leading) {
                            Text(matchTitle(for: partido))
                                .font(.headline)
                            Text("Fecha: \(formatDate(partido.fecha))")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }

                }
            }
        }
        .onAppear {
            fetchPartidosData()
        }
    }

    var filteredPartidos: [APIPartido] {
        if searchText.isEmpty {
            return partidos
        } else {
            return partidos.filter { matchTitle(for: $0).localizedCaseInsensitiveContains(searchText) }
        }
    }

    private func fetchPartidosData() {
        let url = "https://localhost:3443/partidos"
        APIService.shared.fetchPartidos(url: url) { result in
            switch result {
            case .success(let partidos):
                self.partidos = partidos
                fetchEquipoNames(for: partidos)
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func fetchEquipoNames(for partidos: [APIPartido]) {
        let uniqueTeamIds = Set(partidos.flatMap { [$0.equipo_a, $0.equipo_b] })
        for teamId in uniqueTeamIds {
            let url = "https://localhost:3443/equipos/single/\(teamId)"
            APIService.shared.fetchEquipo(url: url) { result in
                switch result {
                case .success(let equipo):
                    self.equipos[teamId] = equipo
                case .failure(let error):
                    print("Failed to fetch team \(teamId): \(error.localizedDescription)")
                }
            }
        }
    }

    private func matchTitle(for partido: APIPartido) -> String {
        let equipoA = equipos[partido.equipo_a]?.nombre_equipo ?? "Equipo A"
        let equipoB = equipos[partido.equipo_b]?.nombre_equipo ?? "Equipo B"
        return "\(equipoA) vs \(equipoB)"
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

struct BusquedaView_Previews: PreviewProvider {
    static var previews: some View {
        BusquedaView()
    }
}
