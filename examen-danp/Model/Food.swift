//
//  FoodModel.swift
//  examen-danp
//
//  Created by atipaq on 21/11/24.
//

import Foundation
import SwiftUI

struct Food: Hashable, Codable, Identifiable {
    let id: Int
    let codigo: Int
    let nombre: String
    let categoria: String
    let imagen: String
    let proteina: Double
    let grasa: Double
    let carbohidrato: Double
    let energia: Double
    var isFavorite: Bool

    
    private var imageName: String
    var image: Image {
            Image(imageName)
        }
    
}
