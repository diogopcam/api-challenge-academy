//
//  DIContainerKey.swift
//  api-challenge
//
//  Created by Diogo Camargo on 18/08/25.
//


import SwiftUI
import SwiftData

private struct DIContainerKey: EnvironmentKey {
    @MainActor // Adicione este atributo
    static let defaultValue: DIContainer = {
        let container = try! ModelContainer(
            for: Product.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        return DIContainer(modelContainer: container)
    }()
}

extension EnvironmentValues {
    var diContainer: DIContainer {
        get { self[DIContainerKey.self] }
        set { self[DIContainerKey.self] = newValue }
    }
}
