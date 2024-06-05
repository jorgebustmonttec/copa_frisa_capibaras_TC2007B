//
//  NotificacionView.swift
//  App
//
//  Created by Miguel Ponce on 16/05/24.
//

import SwiftUI

struct NotificacionView: View {
    var body: some View {
        VStack {
            // Barra de navegación personalizada
            HStack {
                Text("Notificaciones")
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            .padding()

            ScrollView {
                VStack(spacing: 20) {
                    // Tarjeta para "Reglas"
                    NotificationCard(
                        title: "Reglamento del Juego",
                        imageName: "REGLAS",
                        message: "Las reglas de juego "
                    )

                    // Tarjeta para "Premios"
                    NotificationCard(
                        title: "Premios",
                        imageName: "PREMIOS",
                        message: "Categorias y premios "
                    )

                    // Ejemplo de otra tarjeta
                    NotificationCard(
                        title: "Frisa",
                        imageName: "FRISA", // Cambiar según sea necesario
                        message: "Nuestro proposito como asosiación"
                    )
                }
                .padding()
            }
            .font(.title)
            .padding()
        }
        .padding(.horizontal)
    }
}

struct NotificationCard: View {
    var title: String
    var imageName: String
    var message: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
            Text(message)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

struct NotificacionView_Previews: PreviewProvider {
    static var previews: some View {
        NotificacionView()
    }
}


#Preview {
    NotificacionView()
}
