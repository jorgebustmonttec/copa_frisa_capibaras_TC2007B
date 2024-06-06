//
//  LoginView.swift
//  App
//
//  Created by Miguel Ponce on 04/06/24.
//
import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showForgotPassword: Bool = false
    @State private var showSignup: Bool = false
    @State private var navigateToHome: Bool = false
    @State private var showAlert: Bool = false
    @State private var errorMessage: String = ""

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
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()

                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()

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

                    NavigationLink(destination: AplicacionView().navigationBarBackButtonHidden(true), isActive: $navigateToHome) {
                        Button(action: {
                            login()
                        }) {
                            Text("Iniciar Sesión")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal, 30)
                .padding()
                
                Spacer()
            }
            .navigationBarHidden(true)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func login() {
        userViewModel.login(username: username, password: password) { result in
            switch result {
            case .success:
                navigateToHome = true
            case .failure(let error):
                errorMessage = error.localizedDescription
                showAlert = true
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(UserViewModel())
    }
}
