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
    guard let url = URL(string: urlString) else {
        throw NetworkError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        throw NetworkError.networkError(NSError(domain: "", code: -1))
    }
    
    print("Received data: \(String(data: data, encoding: .utf8) ?? "Invalid Data")")
    
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
        Task {
            await fetchData()
        }
    }
    
    func fetchData() async {
        do {
            let apiURL = "http://10.7.126.66:3000/api/food/"
            let response: WorkResponse = try await loadFromAPI(apiURL)
            
            if response.success {
                self.items = response.data
                print("Fetched \(items.count) items")
            } else {
                print("API returned failure response")
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }

}
