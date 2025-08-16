//
//  api_challengeApp.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//

import SwiftUI
import SwiftData

@main
struct api_challengeApp: App {
    
    // Container compartilhado
    let sharedModelContainer: ModelContainer = {
        let schema = Schema([Product.self, CartItem.self])
        
        let configuration = ModelConfiguration() // pode customizar nome do arquivo ou modo inMemory
        
        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Erro ao criar ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            TabBar()
                .modelContainer(sharedModelContainer) // injeta no ambiente
        }
    }
}

