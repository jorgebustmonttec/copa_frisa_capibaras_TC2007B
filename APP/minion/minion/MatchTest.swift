//
//  MatchTest.swift
//  minion
//
//  Created by Jorge Bustamante on 09/06/24.
//
import SwiftUI

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
    var total_goals: Int
}

struct MatchTest: View {
    @State private var pastPartidos: [APIPartido] = []
    @State private var futurePartidos: [APIPartido] = []
    @State private var equipos: [APIEquipo] = []
    @State private var goals: [String: Int] = [:] // Store goals for teams with match ID as key
    @State private var errorMessage: String = ""

    var body: some View {
        ScrollView {
            VStack {
                Image("copa")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
                    .padding(.top)

                Text("Partidos")
                    .font(.largeTitle)
                    .padding()

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                VStack {
                    Text("Partidos Pasados")
                        .font(.headline)
                        .padding()
                    ScrollView {
                        ForEach(pastPartidos) { partido in
                            partidoView(partido: partido)
                        }
                    }
                    .frame(height: 300)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                .padding()

                VStack {
                    Text("Partidos Futuros")
                        .font(.headline)
                        .padding()
                    ScrollView {
                        ForEach(futurePartidos) { partido in
                            partidoView(partido: partido)
                        }
                    }
                    .frame(height: 300)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                .padding()
            }
        }
        .onAppear {
            fetchEquipos()
            fetchPastPartidos()
            fetchFuturePartidos()
        }
    }

    @ViewBuilder
    private func partidoView(partido: APIPartido) -> some View {
        VStack(alignment: .leading) {
            Text("Fecha: \(formatDate(partido.fecha))")
            HStack {
                if let equipoA = getEquipo(by: partido.equipo_a) {
                    if let escudoData = equipoA.escudo, let escudo = UIImage(data: escudoData) {
                        Image(uiImage: escudo)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    Text("Equipo A: \(equipoA.nombre_equipo)")
                }
                Text("Goles A: \(goals["\(partido.id_partido)_\(partido.equipo_a)"] ?? 0)")
            }
            HStack {
                if let equipoB = getEquipo(by: partido.equipo_b) {
                    if let escudoData = equipoB.escudo, let escudo = UIImage(data: escudoData) {
                        Image(uiImage: escudo)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    Text("Equipo B: \(equipoB.nombre_equipo)")
                }
                Text("Goles B: \(goals["\(partido.id_partido)_\(partido.equipo_b)"] ?? 0)")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
        .padding([.bottom, .horizontal])
    }

    private func fetchPastPartidos() {
        fetchPartidos(url: "https://localhost:3443/partidos/pasados") { partidos in
            self.pastPartidos = partidos
            for partido in partidos {
                fetchGoals(for: partido.equipo_a, in: partido.id_partido)
                fetchGoals(for: partido.equipo_b, in: partido.id_partido)
                fetchEquipoShield(by: partido.equipo_a)
                fetchEquipoShield(by: partido.equipo_b)
            }
        }
    }

    private func fetchFuturePartidos() {
        fetchPartidos(url: "https://localhost:3443/partidos/futuros") { partidos in
            self.futurePartidos = partidos
            for partido in partidos {
                fetchGoals(for: partido.equipo_a, in: partido.id_partido)
                fetchGoals(for: partido.equipo_b, in: partido.id_partido)
                fetchEquipoShield(by: partido.equipo_a)
                fetchEquipoShield(by: partido.equipo_b)
            }
        }
    }

    private func fetchPartidos(url: String, completion: @escaping ([APIPartido]) -> Void) {
        APIService.shared.fetchPartidos(url: url) { result in
            switch result {
            case .success(let partidos):
                completion(partidos)
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func fetchGoals(for teamId: Int, in matchId: Int) {
        let url = "https://localhost:3443/puntos/goles/equipo/\(teamId)/partido/\(matchId)/total"
        APIService.shared.fetchGoals(url: url) { result in
            switch result {
            case .success(let goals):
                DispatchQueue.main.async {
                    self.goals["\(matchId)_\(teamId)"] = goals.total_goals
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func fetchEquipoShield(by teamId: Int) {
        let url = "https://localhost:3443/equipos/single/\(teamId)/escudo"
        APIService.shared.fetchEquipoShield(url: url) { result in
            switch result {
            case .success(let shieldData):
                if let index = equipos.firstIndex(where: { $0.id_equipo == teamId }) {
                    DispatchQueue.main.async {
                        self.equipos[index].escudo = shieldData
                    }
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func fetchEquipos() {
        APIService.shared.fetchEquipos { result in
            switch result {
            case .success(let equipos):
                self.equipos = equipos
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

    private func getEquipo(by id: Int) -> APIEquipo? {
        return equipos.first { $0.id_equipo == id }
    }
}

struct MatchTest_Previews: PreviewProvider {
    static var previews: some View {
        MatchTest()
    }
}
