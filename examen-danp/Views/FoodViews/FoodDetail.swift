//
//  FoodDetail.swift
//  examen-danp
//
//  Created by atipaq on 21/11/24.
//

import SwiftUI

struct FoodDetail: View {
    @Environment(ModelData.self) var modelData
    var food: Food

    var foodIndex: Int {
        modelData.items.firstIndex(where: { $0.id == food.id })!
    }

    var body: some View {
        @Bindable var modelData = modelData
        
        ScrollView {

            CircleImage(image: food.image)
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                HStack {
                    Text(food.nombre)
                        .font(.title)
                    FavoriteButton(isSet: $modelData.items[foodIndex].isFavorite)
                }

                HStack {
                    Text(food.categoria)
                    Spacer()
                    Text("\(food.energia, specifier: "%.1f")g energia")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                Divider()

                Text("About \(food.nombre)")
                    .font(.title2)
                Text("\(food.proteina, specifier: "%.1f")g proteina")
            }
            .padding()
        }
        .navigationTitle(food.nombre)
        .navigationBarTitleDisplayMode(.inline)
    }
}
