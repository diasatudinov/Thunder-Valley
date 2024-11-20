//
//  GameSceneView.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 18.11.2024.
//
import Foundation
import SwiftUI
import SpriteKit

struct GameSceneView: UIViewRepresentable {
    @Binding var score: Int
    @Binding var bonus: Double
    @Binding var gameOver: Bool
    var skView: SKView
    var gameScene: GameScene
    var delegate: GameSceneDelegate?
    
    func makeUIView(context: Context) -> SKView {
       
        let scene = gameScene //GameScene(size: skView.bounds.size)
        scene.scaleMode = .resizeFill
        scene.scoreUpdateHandler = { self.score += 1; print(score) }
        scene.gameOverHandler = { self.gameOver = true }
        scene.bonusUpdateHandler = { bonus += 1 }
        scene.bonusResetHandler = { bonus = 0 }
        scene.restartGame()
        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true
        skView.backgroundColor = .clear
        return skView
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
        //
    }
    

}
