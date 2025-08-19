import SwiftUI
import SwiftData

@main
struct ApiChallenge: App {
    let diContainer: DIContainer

    init() {
        do {
            // Container persistente padrão
            let container = try ModelContainer(for: Product.self)
            self.diContainer = DIContainer(modelContainer: container)
        } catch {
            // fallback em memória
            print("⚠️ Erro ao criar container persistente: \(error)")
            let fallback = try! ModelContainer(
                for: Product.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
            self.diContainer = DIContainer(modelContainer: fallback)
        }
    }

    var body: some Scene {
        WindowGroup {
            TabBar()
                .environment(\.diContainer, diContainer)
                .modelContainer(diContainer.modelContainer)
        }
    }
}
