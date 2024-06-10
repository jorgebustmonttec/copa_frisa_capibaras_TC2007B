//
//  MatchTest.swift
//  minion
//
//  Created by Jorge Bustamante on 09/06/24.
//

// MatchTest.swift
import SwiftUI

struct MatchTest: View {
    @State private var pastPartidos: [APIPartido] = []
    @State private var futurePartidos: [APIPartido] = []
    @State private var equipos: [APIEquipo] = []
    @State private var goals: [String: Int] = [:] // Store goals for teams with match ID as key
    @State private var errorMessage: String = ""

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: LeaderboardView()) {
                    Image("copa")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 130)
                }

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
                            NavigationLink(destination: PartidoDetailView(partido: partido)) {
                                partidoCard(partido: partido)
                            }
                            .buttonStyle(PlainButtonStyle()) // Remove blue text link style
                        }
                    }
                    .frame(height: 200) // Slightly taller scroll view
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
                            NavigationLink(destination: PartidoDetailView(partido: partido)) {
                                partidoCard(partido: partido)
                            }
                            .buttonStyle(PlainButtonStyle()) // Remove blue text link style
                        }
                    }
                    .frame(height: 200) // Slightly taller scroll view
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                .padding()
            }
            .onAppear {
                fetchEquipos()
                fetchPastPartidos()
                fetchFuturePartidos()
            }
        }
    }

    @ViewBuilder
    private func partidoCard(partido: APIPartido) -> some View {
        VStack {
            if let equipoA = getEquipo(by: partido.equipo_a), let equipoB = getEquipo(by: partido.equipo_b) {
                HStack {
                    VStack {
                        if let escudoData = equipoA.escudo, let escudo = UIImage(data: escudoData) {
                            Image(uiImage: escudo)
                                .resizable()
                                .frame(width: 40, height: 40)
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        Text(equipoA.nombre_equipo)
                            .font(.subheadline)
                            .bold()
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: 80) // Fixed width to force text wrap
                    }
                    Spacer()
                    VStack {
                        Text("\(goals["\(partido.id_partido)_\(partido.equipo_a)"] ?? 0) - \(goals["\(partido.id_partido)_\(partido.equipo_b)"] ?? 0)")
                            .font(.title)
                            .bold()
                    }
                    Spacer()
                    VStack {
                        if let escudoData = equipoB.escudo, let escudo = UIImage(data: escudoData) {
                            Image(uiImage: escudo)
                                .resizable()
                                .frame(width: 40, height: 40)
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        Text(equipoB.nombre_equipo)
                            .font(.subheadline)
                            .bold()
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: 80) // Fixed width to force text wrap
                    }
                }
                .padding()
                Text(formatDate(partido.fecha))
                    .font(.subheadline)
                    .padding(.top, 10)
            } else {
                ProgressView()
                    .padding()
            }
        }
        .padding(.vertical, 10)
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
