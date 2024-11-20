//
//  SplashScreen.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 19.11.2024.
//

import SwiftUI

struct SplashScreen: View {
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()

                Image(.splash)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 146)
                    .scaleEffect(scale)
                    .animation(
                        Animation.easeInOut(duration: 0.8)
                            .repeatForever(autoreverses: true),
                        value: scale
                    )
                    .onAppear {
                        scale = 1.2
                    }
                Spacer()

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
