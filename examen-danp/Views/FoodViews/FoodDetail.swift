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

    // Busca el índice del alimento en la lista para permitir modificaciones
    var foodIndex: Int? {
        modelData.items.firstIndex(where: { $0.id == food.id })
    }

    var body: some View {
        VStack {
            Spacer()
            // Imagen circular con AsyncImage
            if let url = food.imageURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .foregroundStyle(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .offset(y: -130)
                .padding(.bottom, -130)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .offset(y: -130)
                    .padding(.bottom, -130)
            }

            // Detalles del alimento
            VStack(alignment: .leading) {
                // Título y botón de favoritos
                HStack {
                    Text(food.nombre)
                        .font(.title)
                    
                }

                // Categoría y energía
                HStack {
                    Text(food.categoria)
                    Spacer()
                    Text("\(food.energia, specifier: "%.1f") kcal")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                Divider()

                // Detalles adicionales
                Text("Información nutricional de \(food.nombre)")
                    .font(.title2)
                    .padding(.bottom, 5)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Proteína: \(food.proteina, specifier: "%.1f") g")
                    Text("Grasa: \(food.grasa, specifier: "%.1f") g")
                    Text("Carbohidratos: \(food.carbohidrato, specifier: "%.1f") g")
                }
            }
            .padding()
            Spacer()

        }
        .navigationTitle(food.nombre)
        .navigationBarTitleDisplayMode(.inline)
    }
}
