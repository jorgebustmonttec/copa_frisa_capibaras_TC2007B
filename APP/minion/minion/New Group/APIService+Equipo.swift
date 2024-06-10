//
//  APIService+Equipo.swift
//  minion
//
//  Created by Jorge Bustamante on 09/06/24.
//
import Foundation

extension APIService {
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
    
    func fetchEquipoShield(by teamId: Int, completion: @escaping (Result<Data, APIError>) -> Void) {
        let url = "https://localhost:3443/equipos/single/\(teamId)/escudo"
        var request = URLRequest(url: URL(string: url)!)
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

    func fetchJugadores(url: String, completion: @escaping (Result<[APIJugador], APIError>) -> Void) {
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
                let jugadores = try JSONDecoder().decode([APIJugador].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jugadores))
                }
            } catch {
                completion(.failure(.decodingFailed("Failed to decode jugadores response.")))
            }
        }
        task.resume()
    }
    
    func fetchJugadores(url: String, completion: @escaping (Result<[APIJugadorEquipo], APIError>) -> Void) {
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
                   let jugadores = try JSONDecoder().decode([APIJugadorEquipo].self, from: data)
                   DispatchQueue.main.async {
                       completion(.success(jugadores))
                   }
               } catch {
                   completion(.failure(.decodingFailed("Failed to decode jugadores response.")))
               }
           }
           task.resume()
       }
}
