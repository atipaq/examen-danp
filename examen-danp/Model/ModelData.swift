//
//  ModelData.swift
//  examen-danp
//
//  Created by atipaq on 21/11/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
}

func loadFromAPI<T: Decodable>(_ urlString: String) async throws -> T {
    // Verificar URL válida
    guard let url = URL(string: urlString) else {
        throw NetworkError.invalidURL
    }
    
    // Crear sesión de URLSession
    let (data, response) = try await URLSession.shared.data(from: url)
    
    // Verificar respuesta HTTP
    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        throw NetworkError.networkError(NSError(domain: "", code: -1))
    }
    
    // Decodificar datos
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        throw NetworkError.decodingError(error)
    }
}

@Observable
class ModelData {
    var items: [Food] = []
    
    init() {
        // Inicializar con datos vacíos
        items = []
    }
    
    func fetchData() async {
        do {
            let apiURL = "http://10.7.126.66:3000/api?"
            self.items = try await loadFromAPI(apiURL)
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}
