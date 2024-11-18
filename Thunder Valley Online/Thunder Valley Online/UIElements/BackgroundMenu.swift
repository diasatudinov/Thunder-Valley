//
//  BackgroundMenu.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 18.11.2024.
//

import SwiftUI

struct BackgroundMenu: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.menuBackground)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 4).foregroundColor(.menuLine)
                )
        }
    }
}

#Preview {
    BackgroundMenu()
}
