//
//  APIService+Jugador.swift
//  minion
//
//  Created by Jorge Bustamante on 09/06/24.
//
// APIService+Jugador.swift
import Foundation

extension APIService {
    func fetchAllJugadores(url: String, completion: @escaping (Result<[APIJugadorEquipo], APIError>) -> Void) {
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
    


}
