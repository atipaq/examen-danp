//
//  FoodRoow.swift
//  examen-danp
//
//  Created by atipaq on 21/11/24.
//

import SwiftUI

struct FoodRow: View {
    var food: Food

    var body: some View {
        HStack {
            food.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(food.nombre)

            Spacer()

            if food.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
            }
        }
    }
}
