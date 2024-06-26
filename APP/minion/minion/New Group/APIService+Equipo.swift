//
//  APIService+Equipo.swift
//  minion
//
//  Created by Jorge Bustamante on 09/06/24.
//
import Foundation

struct TotalTeamPoints: Codable {
    var teamId: String
    var totalPoints: Int
}

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
    
    
    func fetchTotalGoalsByTeam(url: String, completion: @escaping (Result<Int, APIError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed))
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                completion(.failure(.requestFailed))
                return
            }
            
            do {
                let result = try JSONDecoder().decode([String: Int].self, from: data)
                if let totalGoals = result["total_goals"] {
                    completion(.success(totalGoals))
                } else {
                    completion(.failure(.decodingFailed("Missing total_goals key")))
                }
            } catch {
                completion(.failure(.decodingFailed(error.localizedDescription)))
            }
        }.resume()
    }
    
    
    func fetchTotalPointsByTeam(url: String, completion: @escaping (Result<Int, APIError>) -> Void) {
         guard let url = URL(string: url) else {
             completion(.failure(.invalidURL))
             return
         }

         let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)
         session.dataTask(with: url) { data, response, error in
             if let error = error {
                 completion(.failure(.requestFailed))
                 print("Request failed with error: \(error.localizedDescription)")
                 return
             }

             guard let data = data else {
                 completion(.failure(.requestFailed))
                 print("No data received")
                 return
             }

             do {
                 let result = try JSONDecoder().decode(TotalTeamPoints.self, from: data)
                 print("Decoded result for points: \(result)")
                 completion(.success(result.totalPoints))
             } catch {
                 completion(.failure(.decodingFailed(error.localizedDescription)))
                 print("Decoding failed with error: \(error.localizedDescription)")
             }
         }.resume()
     }
    
    func fetchTotalWinsByTeam(url: String, completion: @escaping (Result<Int, APIError>) -> Void) {
           guard let url = URL(string: url) else {
               completion(.failure(.invalidURL))
               return
           }

           let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)
           session.dataTask(with: url) { data, response, error in
               if let error = error {
                   completion(.failure(.requestFailed))
                   print(error.localizedDescription)
                   return
               }

               guard let data = data else {
                   completion(.failure(.requestFailed))
                   return
               }

               do {
                   let result = try JSONDecoder().decode([String: Int].self, from: data)
                   if let totalWins = result["total_wins"] {
                       completion(.success(totalWins))
                   } else {
                       completion(.failure(.decodingFailed("Failed to decode total wins")))
                   }
               } catch {
                   completion(.failure(.decodingFailed(error.localizedDescription)))
               }
           }.resume()
       }
    }
    
