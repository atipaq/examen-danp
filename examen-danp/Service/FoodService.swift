//
//  FoodService.swift
//  examen-danp
//
//  Created by atipaq on 21/11/24.
//

import Foundation

class FoodService {
    static let shared = FoodService() // Singleton para reutilizar el servicio
    
    static public let baseURL = "http://http://10.7.126.66:3000/api"
    
    private init() {} // Evita la inicialización externa
    
    // Función para realizar una solicitud GET con parámetros
    func getRequestWithParams<T: Decodable>(endpoint: String, params: [String: String]) async throws -> T {
        var urlComponents = URLComponents(string: "\(FoodService.baseURL)/\(endpoint)")
        
        // Convertir el diccionario de parámetros a una lista de query items
        urlComponents?.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        // Asegurarse de que la URL esté correctamente formateada
        guard let url = urlComponents?.url else {
            throw URLError(.badURL)
        }
        
        // Crear la solicitud GET
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Realizar la solicitud y obtener la respuesta
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Verificar si la respuesta fue exitosa (código 200)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // Decodificar la respuesta en el tipo genérico T
        let decoder = JSONDecoder()
        
        // Intenta decodificar los datos de la respuesta en el tipo esperado T
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw URLError(.cannotDecodeContentData)
        }
    }
    
    // Función genérica para realizar una solicitud GET
    func fetchData<T: Decodable>(endpoint: String, type: T.Type) async throws -> T {
        guard let url = URL(string: "\(FoodService.baseURL)/\(endpoint)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        
        return decodedData
    }
    
    // Función para manejar una solicitud POST
    func postData<T: Encodable, U: Decodable>(endpoint: String, payload: T, responseType: U.Type) async throws -> U {
        guard let url = URL(string: "\(FoodService.baseURL)/\(endpoint)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encodedData = try JSONEncoder().encode(payload)
        request.httpBody = encodedData
        
        let (data, _) = try await URLSession.shared.upload(for: request, from: encodedData)
        let decodedResponse = try JSONDecoder().decode(U.self, from: data)
        
        return decodedResponse
    }
}
