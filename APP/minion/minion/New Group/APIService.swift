//
//  APIService.swift
//  grrrrrr
//
//  Created by Jorge Bustamante on 09/06/24.
//
//
//  APIService.swift
//  minion
//
//  Created by Jorge Bustamante on 05/06/24.
//
import Foundation

struct LoginResponse: Codable {
    var message: String
    var userId: Int?
    var userType: Int?

    enum CodingKeys: String, CodingKey {
        case message
        case userId = "id_usuario"
        case userType = "tipo_usuario"
    }
}

struct SignupResponse: Codable {
    var message: String
    var error: String?
}

struct UserDetails: Codable {
    var id_jugador: Int
    var first_login: Int
    // Add other fields as needed
}

enum APIError: Error, LocalizedError {
    case invalidURL
    case requestFailed
    case decodingFailed(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .requestFailed:
            return "The request failed."
        case .decodingFailed(let message):
            return message
        }
    }
}

struct APIPartido: Codable, Identifiable {
    var id: Int { id_partido }
    var id_partido: Int
    var equipo_a: Int
    var equipo_b: Int
    var fecha: String
    var ganador: Int?
}


struct APIEquipo: Codable {
    var id_equipo: Int
    var nombre_equipo: String
    var escudo: Data?
    var escuela: String
}

struct APIGoals: Codable {
    var total_goals: Int
}

struct APIJugador: Codable {
    var id_jugador: Int
    var fecha_nac: String
    var CURP: String
    var domicilio: String
    var telefono: String
    var nombre: String
    var apellido_p: String
    var apellido_m: String
    var num_imss: String
    var id_equipo: Int
    var posicion: String
    var doc_carta_responsabilidad: String?
    var doc_curp: String?
    var doc_ine: String?
    var id_usuario: Int
    var username: String
    var display_name: String
    var correo: String
    var tipo_usuario: Int
    var imagen: String?
    var created_at: String
    var first_login: Int
    var goles: Int?
    var tarjetas: Int?
    var ultimoJuegoFecha: String?
    var ultimoJuegoResultado: String?
}

struct APILastGameInfo: Codable {
    var message: String
    var date: String
    var result: String
}

struct APIGreenCards: Codable {
    var total_green_cards: Int
}


class APIService {
    static let shared = APIService()

}

struct APIJugadorEquipo: Codable, Identifiable {
    var id_jugador: Int
    var nombre: String
    var id_equipo: Int
    var nombre_equipo: String
    var username: String
    var display_name: String
    var id_usuario: Int
    
    var id: Int { id_jugador }
}

class SelfSignedCertificateDelegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust, let serverTrust = challenge.protectionSpace.serverTrust {
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}

