//
//  GoleoView.swift
//  minion
//
//  Created by Jorge Bustamante on 10/06/24.
//
import SwiftUI

struct GoleoView: View {
    @State private var jugadores: [APIJugadorGoles] = []
    @State private var errorMessage: String = ""

    var body: some View {
        VStack {
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(jugadores.indices, id: \.self) { index in
                    let jugador = jugadores[index]
                    NavigationLink(destination: JugadorPerfilView(userId: jugador.id_usuario)) {
                        HStack {
                            Text("\(jugador.rank ?? 0)")
                                .bold()
                            VStack(alignment: .leading) {
                                Text(jugador.nombre)
                                    .font(.headline)
                                Text(jugador.nombre_equipo)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text("\(jugador.total_goals)")
                                .bold()
                        }
                        .padding()
                        .background(getBackgroundColor(for: index))
                        .cornerRadius(10)
                    }
                }
            }
        }
        .onAppear {
            fetchJugadoresOrderedByGoals()
        }
        .navigationTitle("Goleo")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func getBackgroundColor(for index: Int) -> Color {
        switch index {
        case 0:
            return Color.yellow.opacity(0.3)
        case 1:
            return Color.gray.opacity(0.3)
        case 2:
            return Color.orange.opacity(0.3)
        default:
            return Color.clear
        }
    }

    private func fetchJugadoresOrderedByGoals() {
        let url = "https://localhost:3443/puntos/players/ordered-by-goals"
        APIService.shared.fetchJugadoresOrderedByGoals(url: url) { result in
            switch result {
            case .success(let jugadores):
                self.jugadores = jugadores.enumerated().map { index, jugador in
                    var jugadorWithRank = jugador
                    jugadorWithRank.rank = index + 1
                    return jugadorWithRank
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

struct APIJugadorGoles: Codable, Identifiable {
    var id: Int { id_jugador }
    var id_jugador: Int
    var id_usuario: Int
    var nombre: String
    var id_equipo: Int
    var nombre_equipo: String
    var username: String
    var display_name: String
    var total_goals: Int
    var rank: Int?
}

struct GoleoView_Previews: PreviewProvider {
    static var previews: some View {
        GoleoView()
    }
}

extension APIService {
    func fetchJugadoresOrderedByGoals(url: String, completion: @escaping (Result<[APIJugadorGoles], APIError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed))
                print(error.localizedDescription)
                return
            }

            guard let data = data else {
                completion(.failure(.requestFailed))
                return
            }

            do {
                let jugadores = try JSONDecoder().decode([APIJugadorGoles].self, from: data)
                completion(.success(jugadores))
            } catch {
                completion(.failure(.decodingFailed(error.localizedDescription)))
            }
        }.resume()
    }
}
