//
//  FoodList.swift
//  examen-danp
//
//  Created by atipaq on 21/11/24.
//

import SwiftUI

struct FoodList: View {
    @State private var showFavoritesOnly = false
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

                ForEach(filteredFood) { food in
                    NavigationLink {
                        FoodDetail(food: food)
                    } label: {
                        FoodRow(food: food)
                    }
                }
            }
            .animation(.default, value: filteredFood)
            .navigationTitle("Landmarks")
        } detail: {
            Text("Select a Landmark")
        }
    }
}


#Preview {
    FoodList()
}
