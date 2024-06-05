//
//  EquipoView.swift
//  App
//
//  Created by Miguel Ponce on 16/05/24.
//

import SwiftUI

struct EquipoView: View {
    let nombreEquipo: String = "Nombre de Equipo"
    let jugadores: [Jugador] = [
        Jugador(nombre: "Jose", posicion: "Delantero", numeroGoles: 5, tarjetas: 1),
        Jugador(nombre: "Juan Luis", posicion: "Mediocampista", numeroGoles: 3, tarjetas: 0),
        Jugador(nombre: "Pedro", posicion: "Defensa", numeroGoles: 1, tarjetas: 2),
        Jugador(nombre: "Alonso", posicion: "Portero", numeroGoles: 0, tarjetas: 1)
    ]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Image(systemName: "shield.lefthalf.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    VStack(alignment: .leading) {
                        Text(nombreEquipo)
                            .font(.title)
                            .bold()
                        Text("Escuela")
                            .font(.subheadline)
                        Text("Patrocinador")
                            .font(.subheadline)
                    }
                }

                Text("Jugadores")
                    .font(.headline)

                List(jugadores, id: \.nombre) { jugador in
                    NavigationLink(destination: JugadorView(jugador: jugador)) {
                        Text(jugador.nombre)
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Detalles del Equipo", displayMode: .inline)
        }
    }
}

struct EquipoView_Previews: PreviewProvider {
    static var previews: some View {
        EquipoView()
    }
}



#Preview {
    EquipoView()
}
