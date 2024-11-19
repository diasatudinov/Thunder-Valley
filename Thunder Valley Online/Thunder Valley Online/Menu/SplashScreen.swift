//
//  SplashScreen.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 19.11.2024.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isScaled = false
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()

                Image(.splash)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 146)
                    .scaleEffect(isScaled ? 1 : 0.75)
                    .animation(.easeInOut(duration: 2), value: isScaled)
                Spacer()

            }.onAppear {
                isScaled = true
            }
            Spacer()
        }.background(
            Image(.background)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
    }
}

#Preview {
    SplashScreen()
}
