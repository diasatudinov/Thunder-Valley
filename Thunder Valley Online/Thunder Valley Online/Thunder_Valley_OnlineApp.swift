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
    
    @AppStorage("need") var toUp: Bool = true
    @AppStorage("vers") var verse: Int = 0
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if !toUp && verse != 1 {
                    WVWrap(urlString: MontrealLinks.montrealData)
                } else {
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
            }.onAppear {
                updateIfNeeded()
            }
            
        }
    }
    
    func updateIfNeeded() {
        if toUp {
            Task {
                if await !MontrealResolver.checking() {
                    verse = 1
                    toUp = false
                    
                } else {
                    verse = 0
                    toUp = false
                }
            }
        }
        
        
    }
    
}
