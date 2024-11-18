//
//  GameScene.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 18.11.2024.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    // Categories for collision detection
    let thunderCategory: UInt32 = 0x1 << 0
    let cloudCategory: UInt32 = 0x1 << 1

    // Thunder node
    var thunder: SKSpriteNode!

    override func didMove(to view: SKView) {
        self.backgroundColor = .blue

        // Set up physics world
        self.physicsWorld.contactDelegate = self

        // Add thunder
        thunder = SKSpriteNode(color: .yellow, size: CGSize(width: 40, height: 40))
        thunder.position = CGPoint(x: self.size.width / 2, y: 100)
        thunder.physicsBody = SKPhysicsBody(rectangleOf: thunder.size)
        thunder.physicsBody?.isDynamic = false
        thunder.physicsBody?.categoryBitMask = thunderCategory
        thunder.physicsBody?.contactTestBitMask = cloudCategory
        thunder.physicsBody?.collisionBitMask = 0
        addChild(thunder)

        // Spawn clouds
        let spawnClouds = SKAction.run { self.spawnCloud() }
        let delay = SKAction.wait(forDuration: 1.5)
        let spawnSequence = SKAction.sequence([spawnClouds, delay])
        run(SKAction.repeatForever(spawnSequence))
    }

    func spawnCloud() {
        let cloud = SKSpriteNode(color: .gray, size: CGSize(width: 100, height: 40))
        cloud.position = CGPoint(x: CGFloat.random(in: 0...self.size.width), y: self.size.height)
        cloud.physicsBody = SKPhysicsBody(rectangleOf: cloud.size)
        cloud.physicsBody?.isDynamic = true
        cloud.physicsBody?.categoryBitMask = cloudCategory
        cloud.physicsBody?.contactTestBitMask = thunderCategory
        cloud.physicsBody?.collisionBitMask = 0
        cloud.physicsBody?.velocity = CGVector(dx: 0, dy: -200)
        cloud.physicsBody?.linearDamping = 0
        addChild(cloud)

        // Remove cloud when it goes off screen
        let removeCloud = SKAction.sequence([
            SKAction.wait(forDuration: 5),
            SKAction.removeFromParent()
        ])
        cloud.run(removeCloud)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            thunder.position.x = location.x
        }
    }

    func didBegin(_ contact: SKPhysicsContact) {
        // Handle collision
        if contact.bodyA.categoryBitMask == thunderCategory || contact.bodyB.categoryBitMask == thunderCategory {
            gameOver()
        }
    }

    func gameOver() {
        // Stop the scene and display Game Over
        self.isPaused = true
        let gameOverLabel = SKLabelNode(text: "Game Over")
        gameOverLabel.fontSize = 40
        gameOverLabel.fontColor = .red
        gameOverLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        addChild(gameOverLabel)
    }
}
