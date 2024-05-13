//
//  LoginView.swift
//  RetoIOS
//
//  Created by Gael Gaytan on 03/05/24.
//
import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showForgotPassword: Bool = false
    @State private var showSignup: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(.blue)
                        .padding()
                    }
                    Spacer()
                }
                .padding(.top, 20) // Ajuste de la distancia desde la parte superior
                .padding(.leading, 5)
                
                Image("copa")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 200)
                    .padding(.bottom, 50)

                Text("Ingrese sus datos")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()

                VStack(spacing: 20) {
                    TextField("Usuario", text: $username)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)

                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)

                    NavigationLink(destination: ForgotPasswordView(), isActive: $showForgotPassword) {
                        Button("Olvidé mi contraseña") {
                            showForgotPassword = true
                        }
                        .foregroundColor(.blue)
                    }

                    NavigationLink(destination: SignupView(), isActive: $showSignup) {
                        Button("No tengo cuenta") {
                            showSignup = true
                        }
                        .foregroundColor(.green)
                    }

                    Button(action: {
                        // Acción para iniciar sesión
                    }) {
                        Text("Iniciar Sesión")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 30)
                .padding()
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}



#Preview {
    LoginView()
}
