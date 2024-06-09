//  ContentView.swift
//  App
//
//  Created by Miguel Ponce on 16/05/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        Group {
            if userViewModel.isLoggedIn {
                AplicacionView()
            } else {
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

                        NavigationLink(destination: AplicacionView().navigationBarBackButtonHidden(true)) {
                            Text("Continuar como invitado")
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 50)
                    }
                    .navigationBarHidden(true)
                }
            }
        }
    }
}


