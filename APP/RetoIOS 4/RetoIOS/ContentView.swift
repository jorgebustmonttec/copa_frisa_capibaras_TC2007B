//
//  ContentView.swift
//  RetoIOS
//
//  Created by Alumno on 03/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("copa")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 330, height: 200)
                    .padding(.bottom, 50)
                
                Text("Bienvenido")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()

                NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true)) {
                    Text("Iniciar Sesión")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 30)

                NavigationLink(destination: SignupView()) {
                    Text("Registrarse")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.vertical, 30)
                .padding(.horizontal, 30)

                NavigationLink(destination: GuestView().navigationBarBackButtonHidden(true)) {
                    Text("Continuar como invitado")
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 30)
            }
            .navigationBarHidden(true)
        }
    }
}




#Preview {
    ContentView()
}
