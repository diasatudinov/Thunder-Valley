//
//  GameView.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 18.11.2024.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var counter: Int = 0
    
    @State private var startLabel = true
    @State private var gameShow = false
    @State private var buttonsShow = false
    
    @State var score: Int = 0
    @State var combo: Int = 0
    @State var distance: Int = 0
    @State private var timeRemaining = 10
    @State private var gameOver = false
    @State private var gamePause = false
    @ObservedObject var achievements = AchievementsViewModel()
    let skView = SKView()
    @State var gameScene = GameScene(size: SKView().bounds.size)
    @State var handler: GameSceneDelegate?
    
//    init() {
//
//    }
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if counter < 1 {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("Start")
                                .font(.system(size: 128))
                                .foregroundColor(.white)
                                .textCase(.uppercase)
                            Spacer()
                        }
                           
                        Spacer()
                    }
                }
                
                if counter > 1 {
                    GameSceneView(score: $score, gameOver: $gameOver, skView: skView, gameScene: gameScene).ignoresSafeArea()
                    //.frame(width: geometry.size.width, height: geometry.size.height)
                }
                
                if counter > 0 {
                    VStack {
                        ZStack {
                            HStack {
                                ZStack {
                                    Image(.gameScoreBg)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: geometry.size.width < geometry.size.height ? 35 : 50)
                                    Text("\(score)")
                                        .font(.system(size: geometry.size.width < geometry.size.height ? 25 : 32))
                                        .foregroundColor(.white)
                                }
                            }
                            HStack {
                                Button {
                                    gamePause = true
                                    handler?.pause()
                                } label: {
                                    Image(.pause)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: geometry.size.width < geometry.size.height ? 35 : 50)
                                }
                                
                                Spacer()
                                
                                HStack(spacing: 0) {
                                    if combo > 0 {
                                        Image(.combo)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: geometry.size.width < geometry.size.height ? 30 : 50)
                                            .offset(x: 10)
                                    }
                                    
                                    ZStack {
                                        Image(.gameScoreBg)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: geometry.size.width < geometry.size.height ? 35 : 50)
                                        
                                        HStack {
                                            Image(.sphere)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 30)
                                            Spacer()
                                            Text("\(combo)")
                                                .font(.system(size: geometry.size.width < geometry.size.height ? 25 : 32))
                                                .foregroundColor(.white)
                                            
                                        }.padding(.horizontal).frame(width: geometry.size.width < geometry.size.height ? 100 : 131)
                                    }
                                    
                                }
                                
                                
                            }.padding()
                        }
                        Spacer()
                        HStack {
                            
                            Image(.left)
                                .resizable()
                                .scaledToFit()
                                .frame(height: geometry.size.width < geometry.size.height ? 35 : 50)
                            
                            
                            Spacer()
                            
                            
                            Image(.right)
                                .resizable()
                                .scaledToFit()
                                .frame(height: geometry.size.width < geometry.size.height ? 35 : 50)
                            
                            
                        }.padding(30)
                        
                    }
                }
                
                if gameOver {
                    MenuShield(score: score, distance: distance,
                               retryPressed:{
                        print("retryPressed")
                        gameOver = false
                        score = 0
                        handler?.restart()
                    }, menuPressed: {
                        print("menuPressed")
                        presentationMode.wrappedValue.dismiss()
                    })
                }
                
                if gamePause {
                    PauseShield(resumePressed: {
                        gamePause = false
                        handler?.resume()
                    }, menuPressed: {
                        print("menuPressed")
                        presentationMode.wrappedValue.dismiss()
                    })
                }
               
            }.background(
                Image(.background)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            )
            .onAppear {
                startTimer()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.handler = gameScene
                }
            }
        }
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if counter < 4 {
                withAnimation {
                    counter += 1
                }
            }
            
            if distance >= 0 {
                distance += 20
            }
        }
    }
}

#Preview {
    GameView()
}
