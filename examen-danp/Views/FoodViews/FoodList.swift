//
//  FoodList.swift
//  examen-danp
//
//  Created by atipaq on 21/11/24.
//

import SwiftUI

struct FoodList: View {
    @State private var showFavoritesOnly = false
    @State private var selectedFoodIndex: Int? = nil // Índice del alimento seleccionado
    @Environment(ModelData.self) var modelData

    var filteredFood: [Food] {
        modelData.items.filter { food in
            (!showFavoritesOnly || food.isFavorite)
        }
    }

    var body: some View {
        NavigationSplitView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }

                ForEach(filteredFood.indices, id: \.self) { index in
                    NavigationLink(
                        destination: FoodDetail(food: filteredFood[index]),
                        tag: index,
                        selection: $selectedFoodIndex // Actualiza el índice seleccionado
                    ) {
                        FoodRow(food: filteredFood[index])
                    }
                }
            }
            .animation(.default, value: filteredFood)
            .navigationTitle("Food")
        } detail: {
            if let selectedFoodIndex = selectedFoodIndex {
                VStack {
                    FoodDetail(food: filteredFood[selectedFoodIndex])
                    
                    HStack {
                        Button(action: {
                            navigateToPrevious()
                        }) {
                            Text("Anterior")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .disabled(selectedFoodIndex == 0) // Desactiva si es el primero
                        
                        Button(action: {
                            navigateToNext()
                        }) {
                            Text("Siguiente")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .disabled(selectedFoodIndex == filteredFood.count - 1) // Desactiva si es el último
                    }
                    .padding()
                }
            } else {
                Text("Select a Food")
            }
        }
    }

    // Navega al alimento anterior
    private func navigateToPrevious() {
        if let currentIndex = selectedFoodIndex, currentIndex > 0 {
            selectedFoodIndex = currentIndex - 1
        }
    }

    // Navega al siguiente alimento
    private func navigateToNext() {
        if let currentIndex = selectedFoodIndex, currentIndex < filteredFood.count - 1 {
            selectedFoodIndex = currentIndex + 1
        }
    }
}
