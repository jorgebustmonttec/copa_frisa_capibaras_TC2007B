//
//  StatsView.swift
//  App
//
//  Created by Gael Gaytan on 04/06/24.
//

import SwiftUI

struct StatsView: View {
    var team1: String
    var logo1: String
    var team2: String
    var logo2: String
    var goalsTeam1: [(player: String, minute: Int)]
    var goalsTeam2: [(player: String, minute: Int)]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Estadísticas del partido")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            HStack(spacing: 30) {
                VStack(alignment: .leading) { // Alineación izquierda para el equipo 1
                    Image(logo1)
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text(team1)
                        .font(.headline)
                        .padding(.bottom)
                    
                    ForEach(goalsTeam1.indices, id: \.self) { index in
                        let goal = goalsTeam1[index]
                        HStack {
                            Image(systemName: "person.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.blue)
                                .frame(width: 20, height: 20)
                            
                            Text("\(goal.player) (\(goal.minute)')")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 5)
                    }
                }
                
                Spacer() // Añadir espacio para alinear verticalmente
                
                VStack(alignment: .leading) { // Alineación izquierda para el equipo 2
                    Image(logo2)
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text(team2)
                        .font(.headline)
                        .padding(.bottom)
                    
                    ForEach(goalsTeam2.indices, id: \.self) { index in
                        let goal = goalsTeam2[index]
                        HStack {
                            Image(systemName: "person.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.blue)
                                .frame(width: 20, height: 20)
                            
                            Text("\(goal.player) (\(goal.minute)')")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            .padding()
            
            // Imagen de la cancha de fútbol
            Image("cancha_futbol2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            }
        }
    }

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(team1: "Equipo A", logo1: "logo1", team2: "Equipo B", logo2: "logo2", goalsTeam1: [("Jugador1", 10), ("Jugador2", 25)], goalsTeam2: [("Jugador3", 35), ("Jugador4", 45)])
    }
}
