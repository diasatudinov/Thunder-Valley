//
//  RootView.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 21.11.2024.
//

import SwiftUI

struct RootView: View {
    @State private var isLoading = true
  
    
    
    @State var toUp: Bool = true
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
                            .onAppear {
                                AppDelegate.orientationLock = .landscape
                                setOrientation(.landscapeRight)
                            }
                            .onDisappear {
                                AppDelegate.orientationLock = .all
                            }
                            
                    }
                }
            }
        }
        .onAppear {
            updateIfNeeded()
            print(Links.shared.finalURL)
        }
    }
    
    
    
    func updateIfNeeded() {
        
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
        
        
        
    }
    
    func setOrientation(_ orientation: UIInterfaceOrientation) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let selector = NSSelectorFromString("setInterfaceOrientation:")
            if let responder = windowScene.value(forKey: "keyWindow") as? UIResponder, responder.responds(to: selector) {
                responder.perform(selector, with: orientation.rawValue)
            }
        }
    }

    
}


#Preview {
    RootView()
}
