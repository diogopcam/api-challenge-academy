//
//  SectionHeader.swift
//  api-challenge
//
//  Created by Diogo Camargo on 22/08/25.
//
import SwiftUI

struct SectionHeader: View {
    let title: String
    var showSeeAll: Bool = false
    var onSeeAll: (() -> Void)? = nil

    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .bold()
            Spacer()
            if showSeeAll {
                if let onSeeAll = onSeeAll {
                    Button("See all", action: onSeeAll)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.labelsSecondary)
                } else {
                    Text("See all")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.labelsSecondary)
                }
            }
        }
        // REMOVER maxWidth infinito aqui
        //.frame(maxWidth: .infinity, alignment: .leading)
    }
}
