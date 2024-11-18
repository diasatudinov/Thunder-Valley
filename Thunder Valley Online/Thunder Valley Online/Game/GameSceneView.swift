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
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        let scene = GameScene(size: CGSize(width: 400, height: 800))
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        return skView
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
        //
    }
    

}
