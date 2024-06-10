//
//  APIService+Partido.swift
//  minion
//
//  Created by Jorge Bustamante on 09/06/24.
//
import Foundation

struct EquipoPuntosChart: Codable, Identifiable {
    var id: Int { id_equipo }
    var id_equipo: Int
    var total_points: Int

    enum CodingKeys: String, CodingKey {
        case id_equipo
        case total_points
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id_equipo = try container.decode(Int.self, forKey: .id_equipo)
        let totalPointsString = try container.decode(String.self, forKey: .total_points)
        total_points = Int(totalPointsString) ?? 0
    }
}

extension APIService {
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
    
    func fetchEquiposOrderedByPoints(url: String, completion: @escaping (Result<[EquipoPuntosChart], APIError>) -> Void) {
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
                    let equipos = try JSONDecoder().decode([EquipoPuntosChart].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(equipos))
                    }
                } catch {
                    completion(.failure(.decodingFailed("Failed to decode equipos response.")))
                }
            }
            task.resume()
        }

       
}
