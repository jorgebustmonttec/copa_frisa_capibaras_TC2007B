//
//  APIService+User.swift
//  minion
//
//  Created by Jorge Bustamante on 09/06/24.
//
import Foundation

extension APIService {
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
