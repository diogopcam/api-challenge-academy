import SwiftUI
import SwiftData

struct CartView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var products: [Product]  // pega todos os produtos sem ordem específica

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Produtos no Carrinho")
                    .font(.title2)
                    .bold()
                    .padding(.top)

                if products.isEmpty {
                    Text("Nenhum produto no banco")
                        .foregroundColor(.gray)
                } else {
                    List(products) { product in
                        VStack(alignment: .leading) {
                            Text(product.name)
                                .font(.headline)
                            Text(product.category)
                                .foregroundColor(.secondary)
                            Text("R$ \(product.price, specifier: "%.2f")")
                                .bold()
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .padding()
            .navigationTitle("Carrinho")
        }
        .task {
            // Apenas para debug: printa todos os produtos no console
            print("Produtos no banco:")
            for product in products {
                print("- \(product.name) | \(product.category) | R$ \(product.price)")
            }
        }
    }
}
