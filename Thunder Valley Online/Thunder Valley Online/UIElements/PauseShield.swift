//
//  PauseShield.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 19.11.2024.
//

import SwiftUI

struct PauseShield: View {
    
    var resumePressed: () -> ()
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
                        
                        Text("Pause")
                            .font(.system(size: 28))
                            .textCase(.uppercase)
                            .foregroundColor(.white)
                        
                    }.padding(.top, 30)
                    Spacer()
                    VStack(spacing: 10) {
                        
                        Button {
                            resumePressed()
                        } label: {
                            ZStack {
                                Image(.shieldBtnBg)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                                
                                Text("Resume")
                                    .font(.system(size: 24))
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
                                    .font(.system(size: 24))
                                    .textCase(.uppercase)
                                    .foregroundColor(.white)
                                
                            }
                        }
                    }.padding(.top, 10)
                    Spacer()
                    Spacer()
                }
            }.frame(height: 286)
        }
    }
}

#Preview {
    PauseShield(resumePressed: {}, menuPressed: {})
}
