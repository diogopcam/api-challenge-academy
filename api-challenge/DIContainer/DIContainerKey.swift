//
//  DIContainerKey.swift
//  api-challenge
//
//  Created by Diogo Camargo on 18/08/25.
//


import SwiftUI
import SwiftData

private struct DIContainerKey: EnvironmentKey {
    static let defaultValue: DIContainer = {
        MainActor.assumeIsolated {
            let modelContainer = try! ModelContainer(
                for: Product.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
            return DIContainer(modelContainer: modelContainer)
        }
    }()
}

extension EnvironmentValues {
    var diContainer: DIContainer {
        get { self[DIContainerKey.self] }
        set { self[DIContainerKey.self] = newValue }
    }
}
