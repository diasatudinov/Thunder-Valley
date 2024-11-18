//
//  MenuView.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 18.11.2024.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showGame = false
    @State private var showLeaderboard = false
    @State private var showAchievements = false
    @State private var showSettings = false
    @State private var showRules = false
    @ObservedObject var settings = SettingsModel()

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                Spacer()

                if geometry.size.width < geometry.size.height {
                    // Вертикальная ориентация
                    HStack {
                        Spacer()
                        VStack(spacing: 15) {
                            MenuButton(text: "Play", fontSize: 40) {
                                showGame = true
                            }
                            .frame(height: 100)
                            
                            MenuButton(text: "Achievements", fontSize: 40) {
                                showAchievements = true
                            }
                            .frame(height: 100)
                            
                            MenuButton(text: "Leaderboard", fontSize: 40) {
                                showLeaderboard = true
                            }
                            .frame(height: 100)
                            
                            MenuButton(text: "Settings", fontSize: 40) {
                                
                                showSettings = true
                            }
                            .frame(height: 100)
                            
                            MenuButton(text: "Rules", fontSize: 40) {
                                
                                showRules = true
                            }
                            .frame(height: 100)
                        }
                        Spacer()
                    }
                } else {
                  
                    VStack(spacing: 15) {
                        Spacer()
                        HStack(spacing: 20) {
                            Spacer()
                            MenuButton(text: "Play", fontSize: 40) {
                                showGame = true
                            }
                            .frame(height: 100)

                            MenuButton(text: "Achievements", fontSize: 40) {
                                showAchievements = true
                            }
                            .frame(height: 100)
                            Spacer()
                        }

                        HStack(spacing: 20) {
                            Spacer()
                            MenuButton(text: "Leaderboard", fontSize: 40) {
                                showLeaderboard = true
                            }
                            .frame(height: 100)

                            MenuButton(text: "Settings", fontSize: 40) {
                                
                                showSettings = true
                            }
                            .frame(height: 100)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            MenuButton(text: "Rules", fontSize: 40) {
                                
                                showRules = true
                            }
                            .frame(height: 100)
                            Spacer()
                        }
                        Spacer()
                    }
                }

                Spacer()
            }
            .background(
                Image(.background)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
            )
//            .onAppear {
//                if settings.musicEnabled {
//                    MusicPlayer.shared.playBackgroundMusic()
//                }
//            }
//            .onChange(of: settings.musicEnabled) { enabled in
//                if enabled {
//                    MusicPlayer.shared.playBackgroundMusic()
//                } else {
//                    MusicPlayer.shared.stopBackgroundMusic()
//                }
//            }
            .fullScreenCover(isPresented: $showGame) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Back")
                }
            }
            .fullScreenCover(isPresented: $showLeaderboard) {
                LeaderboardView()
            }
            .fullScreenCover(isPresented: $showAchievements) {
                AchievementsView()
            }
            .fullScreenCover(isPresented: $showSettings) {
                SettingsView()
            }
            .fullScreenCover(isPresented: $showRules) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Back")
                }
            }
        }
    }
}

#Preview {
    MenuView()
}
