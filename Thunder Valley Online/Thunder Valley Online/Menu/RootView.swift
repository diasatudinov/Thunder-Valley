//
//  RootView.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 21.11.2024.
//

import SwiftUI

struct RootView: View {
    @State private var isLoading = true
  
    
    
    @AppStorage("need") var toUp: Bool = true
    @AppStorage("vers") var verse: Int = 0
    
    var body: some View {
        
        ZStack {
            if !toUp && verse == 1 {
                WVWrap(urlString: Links.thunderData)
            } else {
                VStack {
                    if isLoading {
                        SplashScreen()
                    } else {
                        MenuView()
                    }
                }
            }
        }
        .onAppear {
            updateIfNeeded()
        }
    }
    
    
    
    func updateIfNeeded() {
        if toUp {
            Task {
                if await !Resolver.checking() {
                    verse = 1
                    toUp = false
                    isLoading = false
                    
                } else {
                    verse = 0
                    toUp = true
                    isLoading = false
                }
            }
        } else {
            isLoading = false
        }
        
        
    }
    
}


#Preview {
    RootView()
}
