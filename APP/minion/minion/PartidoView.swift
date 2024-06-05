//
//  PartidoView.swift
//  App
//
//  Created by Miguel Ponce on 16/05/24.
//

import SwiftUI

struct PartidoView: View {
    var partido: Partido
    @State private var showStats: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "sportscourt.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.green) // Color del icono, ajustable según tu paleta de colores

                Text("Partido contra \(partido.equipoContrario)")
                    .font(.title)
                    .fontWeight(.bold)
            }

            Divider()

            Group {
                HStack {
                    Text("Fecha:")
                        .font(.headline)
                        .foregroundColor(.blue)
                    Text("\(partido.fecha, formatter: dateFormatter)")
                        .font(.body)
                }

                HStack {
                    Text("Resultado:")
                        .font(.headline)
                        .foregroundColor(.blue)
                    Text("\(partido.resultado)")
                        .font(.body)
                }

                HStack {
                    Text("Detalles del partido:")
                        .font(.headline)
                        .foregroundColor(.blue)
                    Text("\(partido.detalles)")
                        .font(.body)
                }
                
                Button(action: {
                    showStats.toggle()
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 350, height: 100)
                        .overlay(
                            VStack {
                                Text("Ver estadísticas del partido")
                                    .font(.headline)
                                    .padding()
                            }
                        )
                }
                .sheet(isPresented: $showStats) {
                    // Aquí llamamos a la vista StatsView pasando las estadísticas del partido
                    statsView(for: partido)
                }
            }
            .padding(.leading, 10)

            Spacer()
        }
        .padding()
        .navigationBarTitle("Detalles del Partido", displayMode: .inline)
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    @ViewBuilder
    private func statsView(for partido: Partido) -> some View {
        switch partido.equipoContrario {
        case "Equipo E vs Equipo F":
            StatsView(team1: "Equipo E", logo1: "EquipoE", team2: "Equipo F", logo2: "EquipoF", goalsTeam1: [("Jugador1", 10), ("Jugador2", 25), ("Jugador3", 35), ("Jugador4", 45)], goalsTeam2: [])
        case "Equipo G vs Equipo H":
            StatsView(team1: "Equipo G", logo1: "EquipoG", team2: "Equipo H", logo2: "EquipoH", goalsTeam1: [("Jugador5", 15), ("Jugador6", 30), ("Jugador7", 55)], goalsTeam2: [("Jugador8", 20), ("Jugador9", 40), ("Jugador10", 50)])
        case "Equipo A vs Equipo B":
            StatsView(team1: "Equipo A", logo1: "EquipoA", team2: "Equipo B", logo2: "EquipoB", goalsTeam1: [("Jugador11", 10), ("Jugador12", 20)], goalsTeam2: [("Jugador13", 30), ("Jugador14", 40)])
        case "Equipo C vs Equipo D":
            StatsView(team1: "Equipo C", logo1: "EquipoC", team2: "Equipo C", logo2: "EquipoD", goalsTeam1: [("Jugador15", 5), ("Jugador16", 25), ("Jugador17", 35)], goalsTeam2: [("Jugador18", 15)])
        default:
            StatsView(team1: "Equipo X", logo1: "logo1", team2: "Equipo Y", logo2: "logo2", goalsTeam1: [], goalsTeam2: [])
        }
    }
}

struct PartidoView_Previews: PreviewProvider {
    static var previews: some View {
        PartidoView(partido: Partido(equipoContrario: "Equipo E vs Equipo F", fecha: Date(), resultado: "4-0", detalles: "Victoria para Equipo E"))
    }
}

