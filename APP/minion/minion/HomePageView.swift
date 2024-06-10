//
//  HomePageView.swift
//  App
//
//  Created by Miguel Ponce on 04/06/24.
//

import SwiftUI

struct HomePageView: View {
    @State private var showStatsEF: Bool = false
    @State private var showStatsGH: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                Image("copa")
                    .resizable()
                    .frame(width: 150, height: 80)
                    .padding()
                
                ScrollView {
                    VStack {
                        Text("Próximos partidos")
                             
                            .fontWeight(.bold)
                            .padding()
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 350, height: 100)
                            .overlay(
                                VStack {
                                    Text("Fecha: 15/05/2024")
                                        .font(.subheadline)
                                        .padding(.top)
                                    
                                    HStack {
                                        Image("EquipoA")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                        Text("EquipoA")
                                            .font(.headline)
                                            .padding()
                                        
                                        Text("vs")
                                            .font(.headline)
                                        
                                        Text("EquipoB")
                                            .font(.headline)
                                            .padding()
                                        Image("EquipoB")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                    }
                                }
                            )
                            .padding()
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 350, height: 100)
                            .overlay(
                                VStack {
                                    Text("Fecha: 16/05/2024")
                                        .font(.subheadline)
                                        .padding(.top)
                                    
                                    HStack {
                                        Image("EquipoC")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                        Text("EquipoC")
                                            .font(.headline)
                                            .padding()
                                        
                                        Text("vs")
                                            .font(.headline)
                                        
                                        Text("EquipoD")
                                            .font(.headline)
                                            .padding()
                                        Image("EquipoD")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                    }
                                }
                            )
                            .padding()
                    }
                }
                .background(Color.blue.opacity(0.1))
                .cornerRadius(15)
                .padding()
                
                ScrollView {
                    VStack {
                        Text("Partidos pasados")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                        
                        VStack(spacing: 10) {
                            Button(action: {
                                showStatsEF.toggle()
                            }) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 350, height: 100)
                                    .overlay(
                                        VStack {
                                            Text("Fecha: 14/05/2024")
                                                .font(.subheadline)
                                                .padding(.top)
                                            
                                            HStack {
                                                Text("EquipoE")
                                                    .font(.headline)
                                                    .padding()
                                                
                                                Text("4 - 0")
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                
                                                Text("EquipoF")
                                                    .font(.headline)
                                                    .padding()
                                            }
                                        }
                                    )
                            }
                            .padding(10)
                            .sheet(isPresented: $showStatsEF) {
                                StatsView(team1: "EquipoE", logo1: "pelota", team2: "EquipoF", logo2: "escudo", goalsTeam1: [("Jugador1", 10), ("Jugador2", 25), ("Jugador3", 35), ("Jugador4", 45)], goalsTeam2: [])
                            }
                            
                            Button(action: {
                                showStatsGH.toggle()
                            }) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 350, height: 100)
                                    .overlay(
                                        VStack {
                                            Text("Fecha: 13/05/2024")
                                                .font(.subheadline)
                                                .padding(.top)
                                            
                                            HStack {
                                                Text("EquipoG")
                                                    .font(.headline)
                                                    .padding()
                                                
                                                Text("3 - 3")
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                
                                                Text("EquipoH")
                                                    .font(.headline)
                                                    .padding()
                                            }
                                        }
                                    )
                            }
                            .padding()
                            .sheet(isPresented: $showStatsGH) {
                                StatsView(team1: "EquipoG", logo1: "pelota", team2: "EquipoH", logo2: "escudo", goalsTeam1: [("Jugador5", 15), ("Jugador6", 30), ("Jugador7", 55)], goalsTeam2: [("Jugador8", 20), ("Jugador9", 40), ("Jugador10", 50)])
                            }
                        }
                    }
                }
                .background(Color.green.opacity(0.1))
                .cornerRadius(15)
                .padding(10)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
