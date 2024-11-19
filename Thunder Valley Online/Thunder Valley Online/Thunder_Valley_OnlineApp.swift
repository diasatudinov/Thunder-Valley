//
//  Thunder_Valley_OnlineApp.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 18.11.2024.
//

import SwiftUI

@main
struct Thunder_Valley_OnlineApp: App {
    @State private var isMenu = false
    var body: some Scene {
        WindowGroup {
            
            if isMenu {
                MenuView()
            } else {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                            withAnimation {
                                isMenu = true
                            }
                        }
                    }
            }
            
        }
    }
}
