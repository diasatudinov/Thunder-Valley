//
//  menuShield.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 19.11.2024.
//

import SwiftUI

struct MenuShield: View {
    @State var score: Int
    @State var distance: Int
    
    var retryPressed: () -> ()
    var menuPressed: () -> ()
    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
            ZStack {
                Image(.menuShield)
                    .resizable()
                    .scaledToFit()
                VStack(spacing: 0) {
                    ZStack {
                        Image(.shieldTextBg)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 38)
                            
                        Text("Game Over!")
                            .font(.custom("AbhayaLibre-Regular", size: 28))
                            .textCase(.uppercase)
                            .foregroundColor(.white)
                            
                    }.padding(.top, 30)
                    
                    VStack(spacing: 5) {
                        Text("Score")
                            .font(.custom("AbhayaLibre-Regular", size: 15))
                            .textCase(.uppercase)
                            .foregroundColor(.white)
                        ZStack {
                            Image(.scoreBg)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 16)
                            
                            Text("\(score)")
                                .font(.custom("AbhayaLibre-Regular", size: 10))
                                .textCase(.uppercase)
                                .foregroundColor(.white)
                        }
                    }.padding(.top, 10)
                    
                    VStack(spacing: 5) {
                        Text("distance covered")
                            .font(.custom("AbhayaLibre-Regular", size: 15))
                            .textCase(.uppercase)
                            .foregroundColor(.white)
                        ZStack {
                            Image(.scoreBg)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 16)
                            
                            Text("\(distance) M")
                                .font(.custom("AbhayaLibre-Regular", size: 10))
                                .textCase(.uppercase)
                                .foregroundColor(.white)
                        }
                    }.padding(.top, 10)
                    
                    VStack(spacing: 10) {
                        
                        Button {
                            retryPressed()
                        } label: {
                            ZStack {
                                Image(.shieldBtnBg)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                                
                                Text("Retry")
                                    .font(.custom("AbhayaLibre-Regular", size: 24))
                                    .textCase(.uppercase)
                                    .foregroundColor(.white)
                                
                            }
                        }
                        
                        Button {
                            menuPressed()
                        } label: {
                            ZStack {
                                Image(.shieldBtnBg)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                                
                                Text("Menu")
                                    .font(.custom("AbhayaLibre-Regular", size: 24))
                                    .textCase(.uppercase)
                                    .foregroundColor(.white)
                                
                            }
                        }
                    }.padding(.top, 10)
                    Spacer()
                }
            }.frame(height: 286)
        }
    }
}

#Preview {
    MenuShield(score: 100, distance: 1000, retryPressed: {}, menuPressed: {})
}
