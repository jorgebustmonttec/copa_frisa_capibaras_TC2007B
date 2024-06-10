//
//  EditUserInfoView.swift
//  minion
//
//  Created by Jorge Bustamante on 10/06/24.
//
import SwiftUI

struct EditUserInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var userData: UsuarioDataFull?
    @State private var username: String = ""
    @State private var displayName: String = ""
    @State private var email: String = ""
    @State private var errorMessage: String = ""
    @State private var showAlert: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                if let userData = userData {
                    Form {
                        Section(header: Text("Información del Usuario")) {
                            TextField(userData.username, text: $username)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(10)
                            TextField(userData.display_name, text: $displayName)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(10)
                            TextField(userData.correo, text: $email)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(10)
                                .keyboardType(.emailAddress)
                        }

                        Button(action: {
                            updateUserInfo()
                        }) {
                            Text("Guardar Cambios")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                } else {
                    ProgressView("Cargando datos...")
                }
            }
            .navigationTitle("Editar Información")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .onAppear {
                fetchUserData()
            }
        }
    }

    private func fetchUserData() {
        guard let userId = userViewModel.userId else {
            errorMessage = "ID de usuario no encontrado."
            showAlert = true
            return
        }

        let url = "https://localhost:3443/usuarios/single/\(userId)"
        APIService.shared.getUsuarioDataById(url: url) { result in
            switch result {
            case .success(let userData):
                DispatchQueue.main.async {
                    self.userData = userData
                    self.username = userData.username
                    self.displayName = userData.display_name
                    self.email = userData.correo
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.showAlert = true
                }
            }
        }
    }

    private func updateUserInfo() {
        guard !username.isEmpty, !displayName.isEmpty, !email.isEmpty else {
            errorMessage = "Todos los campos son obligatorios."
            showAlert = true
            return
        }

        guard let userId = userViewModel.userId else {
            errorMessage = "ID de usuario no encontrado."
            showAlert = true
            return
        }

        let url = "https://localhost:3443/usuarios/update/\(userId)"
        let updatedUserData = UsuarioDataFull(
            id_usuario: userId,
            username: username,
            display_name: displayName,
            correo: email,
            password: userData?.password ?? "",
            tipo_usuario: userData?.tipo_usuario ?? 0,
            imagen: userData?.imagen,
            created_at: userData?.created_at ?? "",
            first_login: userData?.first_login ?? 0
        )

        APIService.shared.updateUsuario(url: url, userData: updatedUserData) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.errorMessage = response.message
                    self.showAlert = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.showAlert = true
                }
            }
        }
    }
}

struct EditUserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserInfoView().environmentObject(UserViewModel())
    }
}
