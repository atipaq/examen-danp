//
//  examen_danpApp.swift
//  examen-danp
//
//  Created by atipaq on 21/11/24.
//

import SwiftUI

@main
struct examen_danpApp: App {
    @State private var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
    }
}
