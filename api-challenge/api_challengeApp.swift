//
//  api_challengeApp.swift
//  api-challenge
//
//  Created by Diogo Camargo on 13/08/25.
//

import SwiftUI
import SwiftData

//@main
//struct api_challengeApp: App {
//    
//    // Container compartilhado
//    let sharedModelContainer: ModelContainer = {
//        let schema = Schema([Product.self])
//        
//        
//        //let configuration = ModelConfiguration() // pode customizar nome do arquivo ou modo inMemory
//        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
//        
//        do {
//            return try ModelContainer(for: schema, configurations: [configuration])
//        } catch {
//            fatalError("Erro ao criar ModelContainer: \(error)")
//        }
//    }()
//    
//    var body: some Scene {
//        WindowGroup {
//            TabBar()
//                .modelContainer(sharedModelContainer)
////                .onAppear {
////                        
////                                    clearDatabase()
////                                
////                                }// injeta no ambiente
//        }
//    }
//    
////    func clearDatabase() {
////        print("Antes de apagar:")
////        if let all = try? sharedModelContainer.mainContext.fetch(FetchDescriptor<Product>()) {
////            for p in all {
////                print("Produto: \(p.name), tipo: \(p.typeString)")
////            }
////        }
////
////        
////        let context = sharedModelContainer.mainContext
////        print("🧹 Limpando banco de dados...")
////
////        if let allProducts = try? context.fetch(FetchDescriptor<Product>()) {
////            for product in allProducts {
////                context.delete(product)
////            }
////        }
////
////        if let allCartItems = try? context.fetch(FetchDescriptor<Product>()) {
////            for item in allCartItems {
////                context.delete(item)
////            }
////        }
////
////        try? context.save()
////        print("✅ Banco de dados limpo.")
////    }
//}

@main
struct api_challengeApp: App {
    
    // 1️⃣ Criação do ModelContainer
    let sharedModelContainer: ModelContainer = {
        let schema = Schema([Product.self])
        let configuration = ModelConfiguration() // pode personalizar
        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Erro ao criar ModelContainer: \(error)")
        }
    }()
    
    // 2️⃣ Serviço injetado no App
    @StateObject private var userProductsService: UserProductsService
    
    init() {
        // Cria o serviço passando o context do container
        let context = sharedModelContainer.mainContext
        let service = UserProductsService(context: context)
        _userProductsService = StateObject(wrappedValue: service)
    }
    
    var body: some Scene {
        WindowGroup {
            TabBar()
                .environmentObject(userProductsService) // disponibiliza para todas as views
                .modelContainer(sharedModelContainer)   // injeta o ModelContainer
        }
    }
}
