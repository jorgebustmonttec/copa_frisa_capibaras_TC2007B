//
//  UserOptionsView.swift
//  minion
//
//  Created by Jorge Bustamante on 05/06/24.
//
import SwiftUI

struct UsuarioDataFull: Codable {
    var id_usuario: Int
    var username: String
    var display_name: String
    var correo: String
    var password: String
    var tipo_usuario: Int
    var imagen: String?
    var created_at: String
    var first_login: Int
}


struct UserOptionsView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var userData: UsuarioDataFull?
    @State private var errorMessage: String = ""
    @State private var showAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            if userViewModel.isLoggedIn, let userData = userData {
                VStack(spacing: 10) {
                    Text("Información del Usuario")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    UserInfoRow(label: "ID de Usuario", value: "\(userData.id_usuario)")
                    UserInfoRow(label: "Tipo de Usuario", value: userTypeDescription(userData.tipo_usuario))
                    UserInfoRow(label: "Nombre de Usuario", value: userData.username)
                    UserInfoRow(label: "Nombre para Mostrar", value: userData.display_name)
                    UserInfoRow(label: "Correo Electrónico", value: userData.correo)
                }
                .padding()

                VStack(spacing: 15) {
                    NavigationLink(destination: EditUserInfoView().environmentObject(userViewModel)) {
                        Text("Editar Información")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }

                    NavigationLink(destination: ChangePasswordSheetView().navigationBarHidden(true).environmentObject(userViewModel)) {
                        Text("Cambiar Contraseña")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(10)
                    }

                    Button(action: {
                        userViewModel.logout()
                    }) {
                        Text("Cerrar Sesión")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            } else {
                Text("No has iniciado sesión.")
                    .font(.title)
                    .padding()
                NavigationLink(destination: ContentView().navigationBarHidden(true)) {
                    Text("Ir a Iniciar Sesión")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .navigationTitle("Opciones del Usuario")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            fetchUserData()
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
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.showAlert = true
                }
            }
        }
    }

    private func userTypeDescription(_ userType: Int) -> String {
        switch userType {
        case 1:
            return "Administrador"
        case 2:
            return "Jugador"
        case 3:
            return "Espectador"
        default:
            return "Desconocido"
        }
    }
}

struct UserInfoRow: View {
    var label: String
    var value: String

    var body: some View {
        HStack {
            Text(label + ":")
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.body)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 5)
    }
}

struct UserOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        UserOptionsView().environmentObject(UserViewModel())
    }
}
