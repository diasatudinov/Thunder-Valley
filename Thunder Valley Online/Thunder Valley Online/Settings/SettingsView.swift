//
//  SettingsView.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 18.11.2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var settings = SettingsModel()

    var body: some View {
        ZStack {
                
                VStack(spacing: 0) {
                    Text("Settings")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .padding(.top, 30)
                        .padding(.bottom, 15)
                    VStack(spacing: 12) {
                        Text("Effects")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                        HStack(spacing: 7) {
                            Button {
                                settings.soundEnabled = false
                            } label: {
                                Image(.minusBtn)
                            }
                            HStack(spacing: 2) {
                                ForEach(0..<8) { index in
                                    Image(.soundPart)
                                        .opacity(settings.soundEnabled ? 1 : 0.2)
                                    //                                                Rectangle()
                                    //                                                    .fill(index < soundLevel ? Color.blue : Color.gray)
                                    //                                                    .frame(width: 20, height: 20)
                                    //                                                    .border(Color.black, width: 1)
                                }
                            }.padding(3).padding(.horizontal, 1).background(
                                Color.black
                            ).cornerRadius(5)
                            Button {
                                settings.soundEnabled = true
                            } label: {
                                Image(.plusBtn)
                            }
                        }.padding(.horizontal, 25)
                    }.padding(.bottom, 11)
                    
                    VStack(spacing: 12) {
                        Text("Music")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                        HStack(spacing: 7) {
                            Button {
                                settings.musicEnabled = false
                            } label: {
                                Image(.minusBtn)
                            }
                            HStack(spacing: 2) {
                                ForEach(0..<8) { index in
                                    Image(.soundPart)
                                        .opacity(settings.musicEnabled ? 1 : 0.2)
                                    //                                                Rectangle()
                                    //                                                    .fill(index < soundLevel ? Color.blue : Color.gray)
                                    //                                                    .frame(width: 20, height: 20)
                                    //                                                    .border(Color.black, width: 1)
                                }
                            }.padding(3).padding(.horizontal, 1).background(
                                Color.black
                            ).cornerRadius(5)
                            Button {
                                settings.musicEnabled = true
                            } label: {
                                Image(.plusBtn)
                            }
                        }.padding(.horizontal, 25)
                    }.padding(.bottom, 30)
                    
                }.background(
                    
                    BackgroundMenu()
                )
            
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(.backBtn)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                    }

                   
                    Spacer()
                }
                
                Spacer()
            }
            
        }.textCase(.uppercase).background(
            Image(.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
        )
    }
}

#Preview {
    SettingsView()
}
