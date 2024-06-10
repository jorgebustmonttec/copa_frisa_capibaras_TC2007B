//
//  NotificacionView.swift
//  App
//
//  Created by Miguel Ponce on 16/05/24.
//

import SwiftUI

struct NotificacionView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Notificaciones")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                .padding()

                ScrollView {
                    VStack(spacing: 20) {
                        NavigationLink(destination: NotaView(title: "Reglamento del Juego", imageName: "REGLAS", message: "Las reglas de juego")) {
                            NotificationCard(
                                title: "Reglamento del Juego",
                                imageName: "REGLAS",
                                message: "Las reglas de juego"
                            )
                        }

                        NavigationLink(destination: NotaView(title: "Premios", imageName: "PREMIOS", message: "Categorias y premios")) {
                            NotificationCard(
                                title: "Premios",
                                imageName: "PREMIOS",
                                message: "Categorias y premios"
                            )
                        }

                        NavigationLink(destination: NotaView(title: "Frisa", imageName: "FRISA", message: "Nuestro propósito como asociación")) {
                            NotificationCard(
                                title: "Frisa",
                                imageName: "FRISA",
                                message: "Nuestro propósito como asociación"
                            )
                        }
                    }
                    .padding()
                }
            }
            .padding(.horizontal)
            .navigationBarHidden(true)
        }
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
