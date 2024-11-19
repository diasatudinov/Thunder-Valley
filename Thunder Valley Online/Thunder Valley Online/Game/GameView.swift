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
    @State var score: Int = 0
    @State var distance: Int = 0
    @State private var timeRemaining = 10
    @State private var gameOver = false
    @ObservedObject var achievements = AchievementsViewModel()
    let skView = SKView()
    @State var gameScene = GameScene(size: SKView().bounds.size)
    var handler: GameSceneDelegate?
    
    init() {
        self.handler = gameScene
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GameSceneView(score: $score, gameOver: $gameOver, skView: skView, gameScene: gameScene).ignoresSafeArea()
                    //.frame(width: geometry.size.width, height: geometry.size.height)
                
                VStack {
                    HStack {
                        Text("\(score)")
                            .foregroundColor(.white)
                        Spacer()
                    }.padding()
                    Spacer()
                }
                
                if gameOver {
                    MenuShield(score: score, distance: distance,
                               retryPressed:{
                        print("retryPressed")
                        gameOver = false
                        handler?.restart()
                    }, menuPressed: {
                        print("menuPressed")
                    })
                }
               
            }
        }
    }
}

#Preview {
    GameView()
}
