//
//  FoodModel.swift
//  examen-danp
//
//  Created by atipaq on 21/11/24.
//

import Foundation
import SwiftUI

struct Food: Hashable, Codable, Identifiable {
    let id = UUID() // Generar un ID local ya que el JSON no proporciona uno único.
    let codigo: Int
    let nombre: String
    let categoria: String
    let imageName: String
    let proteina: Double
    let grasa: Double
    let carbohidrato: Double
    let energia: Double
    var isFavorite: Bool = false

    var imageURL: URL? {
        URL(string: "http://10.7.126.66:3000/api/img/\(imageName)")
    }

    enum CodingKeys: String, CodingKey {
        case codigo, nombre, categoria, imageName = "imagen", proteina, grasa, carbohidrato, energia
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        codigo = try container.decode(Int.self, forKey: .codigo)
        nombre = try container.decode(String.self, forKey: .nombre)
        categoria = try container.decode(String.self, forKey: .categoria)
        imageName = try container.decode(String.self, forKey: .imageName)
        proteina = Double(try container.decode(String.self, forKey: .proteina)) ?? 0.0
        grasa = Double(try container.decode(String.self, forKey: .grasa)) ?? 0.0
        carbohidrato = Double(try container.decode(String.self, forKey: .carbohidrato)) ?? 0.0
        energia = Double(try container.decode(String.self, forKey: .energia)) ?? 0.0
    }
}

