//
//  SignupView.swift
//  App
//
//  Created by Miguel Ponce on 04/06/24.
//
import SwiftUI

struct SignupView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.blue)
                    .padding()
                    Spacer()
                }
                
                HStack {
                    Text("Copa Frisa")
                        .font(.title)
                        .fontWeight(.bold)
                    Image("copa")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 80)
                        .padding()
                }
                VStack(spacing: 20) {
                    Text("Ingrese sus datos")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    TextField("Usuario", text: $username)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)

                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .textContentType(.newPassword)
                        .keyboardType(.asciiCapable)

                    SecureField("Confirmar Contraseña", text: $confirmPassword)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .textContentType(.newPassword)
                        .keyboardType(.asciiCapable)
                    
                    TextField("Correo", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)

                    Button(action: {
                        signUp()
                    }) {
                        Text("Crear cuenta")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 30)
                .padding()
                
                Spacer()
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Signup"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func signUp() {
        guard !username.isEmpty, !password.isEmpty, !confirmPassword.isEmpty, !email.isEmpty else {
            alertMessage = "All fields are required."
            showAlert = true
            return
        }
        
        guard password == confirmPassword else {
            alertMessage = "Passwords do not match."
            showAlert = true
            return
        }
        
        APIService.shared.signup(username: username, displayName: username, email: email, password: password) { result in
            switch result {
            case .success(let response):
                alertMessage = response.message
                showAlert = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    presentationMode.wrappedValue.dismiss()
                }
            case .failure(let error):
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
    }
}

#Preview {
    SignupView()
}
