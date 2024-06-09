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




class APIService {
    static let shared = APIService()

    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, APIError>) -> Void) {
        guard let url = URL(string: "https://localhost:3443/usuarios/login") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["username": username, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(loginResponse))
                    }
                } catch {
                    completion(.failure(.decodingFailed("Failed to decode successful login response.")))
                }
            } else {
                do {
                    let errorResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.failure(.decodingFailed(errorResponse.message)))
                    }
                } catch {
                    completion(.failure(.decodingFailed("Failed to decode error response.")))
                }
            }
        }
        task.resume()
    }
    
    func fetchUserDetails(userId: Int, completion: @escaping (Result<UserDetails, APIError>) -> Void) {
        guard let url = URL(string: "https://localhost:3443/jugadores/singlebyuser/\(userId)") else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    let userDetails = try JSONDecoder().decode(UserDetails.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(userDetails))
                    }
                } catch {
                    completion(.failure(.decodingFailed("Failed to decode user details response.")))
                }
            } else {
                completion(.failure(.requestFailed))
            }
        }
        task.resume()
    }
    
    func signup(username: String, displayName: String, email: String, password: String, completion: @escaping (Result<SignupResponse, APIError>) -> Void) {
        guard let url = URL(string: "https://localhost:3443/usuarios/signup") else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["username": username, "display_name": displayName, "correo": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                do {
                    let signupResponse = try JSONDecoder().decode(SignupResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(signupResponse))
                    }
                } catch {
                    completion(.failure(.decodingFailed("Failed to decode successful signup response.")))
                }
            } else {
                do {
                    let errorResponse = try JSONDecoder().decode(SignupResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.failure(.decodingFailed(errorResponse.error ?? "Unknown error")))
                    }
                } catch {
                    completion(.failure(.decodingFailed("Failed to decode error response.")))
                }
            }
        }
        task.resume()
    }
    
    func changePassword(userId: Int, newPassword: String, completion: @escaping (Result<Void, APIError>) -> Void) {
        guard let url = URL(string: "https://localhost:3443/usuarios/changePassword") else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["userId": userId, "newPassword": newPassword]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }

            if httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.failure(.requestFailed))
            }
        }
        task.resume()
    }
    
    
    func fetchPartidos(url: String, completion: @escaping (Result<[APIPartido], APIError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed))
                return
            }

            guard let data = data else {
                completion(.failure(.requestFailed))
                return
            }

            do {
                let partidos = try JSONDecoder().decode([APIPartido].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(partidos))
                }
            } catch {
                completion(.failure(.decodingFailed("Failed to decode partidos response.")))
            }
        }
        task.resume()
    }

    func fetchEquipos(completion: @escaping (Result<[APIEquipo], APIError>) -> Void) {
        guard let url = URL(string: "https://localhost:3443/equipos") else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed))
                return
            }

            guard let data = data else {
                completion(.failure(.requestFailed))
                return
            }

            do {
                let equipos = try JSONDecoder().decode([APIEquipo].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(equipos))
                }
            } catch {
                completion(.failure(.decodingFailed("Failed to decode equipos response.")))
            }
        }
        task.resume()
    }
    
    
    
    // Add these functions inside the APIService class

    // Add these functions inside the APIService class

    func fetchGoals(url: String, completion: @escaping (Result<APIGoals, APIError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed))
                return
            }

            guard let data = data else {
                completion(.failure(.requestFailed))
                return
            }

            do {
                let goals = try JSONDecoder().decode(APIGoals.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(goals))
                }
            } catch {
                completion(.failure(.decodingFailed("Failed to decode goals response.")))
            }
        }
        task.resume()
    }

    func fetchEquipoShield(url: String, completion: @escaping (Result<Data, APIError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed))
                return
            }

            guard let data = data else {
                completion(.failure(.requestFailed))
                return
            }

            completion(.success(data))
        }
        task.resume()
    }

    

    



    

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

extension APIService {
    func fetchJugador(url: String, completion: @escaping (Result<APIJugador, APIError>) -> Void) {
            guard let url = URL(string: url) else {
                completion(.failure(.invalidURL))
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"

            let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(.requestFailed))
                    return
                }

                guard let data = data else {
                    completion(.failure(.requestFailed))
                    return
                }

                do {
                    let jugador = try JSONDecoder().decode(APIJugador.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(jugador))
                    }
                } catch {
                    completion(.failure(.decodingFailed("Failed to decode jugador response.")))
                }
            }
            task.resume()
        }

        func fetchEquipo(url: String, completion: @escaping (Result<APIEquipo, APIError>) -> Void) {
            guard let url = URL(string: url) else {
                completion(.failure(.invalidURL))
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"

            let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(.requestFailed))
                    return
                }

                guard let data = data else {
                    completion(.failure(.requestFailed))
                    return
                }

                do {
                    let equipo = try JSONDecoder().decode(APIEquipo.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(equipo))
                    }
                } catch {
                    completion(.failure(.decodingFailed("Failed to decode equipo response.")))
                }
            }
            task.resume()
        }
    func fetchLastGameInfo(url: String, completion: @escaping (Result<APILastGameInfo, APIError>) -> Void) {
           guard let url = URL(string: url) else {
               completion(.failure(.invalidURL))
               return
           }

           var request = URLRequest(url: url)
           request.httpMethod = "GET"

           let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)
           let task = session.dataTask(with: request) { data, response, error in
               if let error = error {
                   completion(.failure(.requestFailed))
                   return
               }

               guard let data = data else {
                   completion(.failure(.requestFailed))
                   return
               }

               do {
                   let lastGameInfo = try JSONDecoder().decode(APILastGameInfo.self, from: data)
                   DispatchQueue.main.async {
                       completion(.success(lastGameInfo))
                   }
               } catch {
                   completion(.failure(.decodingFailed("Failed to decode last game info response.")))
               }
           }
           task.resume()
       }
    
    func fetchGreenCards(url: String, completion: @escaping (Result<APIGreenCards, APIError>) -> Void) {
            guard let url = URL(string: url) else {
                completion(.failure(.invalidURL))
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"

            let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(.requestFailed))
                    return
                }

                guard let data = data else {
                    completion(.failure(.requestFailed))
                    return
                }

                do {
                    let greenCards = try JSONDecoder().decode(APIGreenCards.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(greenCards))
                    }
                } catch {
                    completion(.failure(.decodingFailed("Failed to decode green cards response.")))
                }
            }
            task.resume()
        }
}
