//
//  GameScene.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 18.11.2024.
//

import SpriteKit

protocol GameSceneDelegate: AnyObject {
    func restart()
    func pause()
    func resume()
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var duration: Double {
        return UIDevice.current.orientation.isPortrait ? 4 : 2
    }
    
    var shiftUp: Double {
        return UIDevice.current.orientation.isPortrait ? 200 : 50
    }
    
    var scoreUpdateHandler: (() -> Void)?
    var gameOverHandler: (() -> Void)?
    
    var isGameOver = false
    // Categories for collision detection
    let thunderCategory: UInt32 = 0x1 << 0
    let cloudCategory: UInt32 = 0x1 << 1
    
    // Thunder node
    var thunder: SKSpriteNode!
    var thunderName: String = "thunder"
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = .clear
        
        // Set up physics world
        self.physicsWorld.contactDelegate = self

        // Spawn clouds
        
        startGame()
    }

    func spawnCloud() {
        let cloudNumber = Int.random(in: 1...3)
        let cloud = SKSpriteNode(imageNamed: "cloud\(cloudNumber)")
        cloud.position = CGPoint(x: CGFloat.random(in: 0...self.size.width), y: 0)
        cloud.physicsBody = SKPhysicsBody(rectangleOf: cloud.size)
        cloud.physicsBody?.isDynamic = true
        cloud.physicsBody?.affectedByGravity = false
        cloud.physicsBody?.categoryBitMask = cloudCategory
        cloud.physicsBody?.contactTestBitMask = thunderCategory
        cloud.physicsBody?.collisionBitMask = 0
        cloud.physicsBody?.velocity = CGVector(dx: 0, dy: 200)
        cloud.physicsBody?.linearDamping = 0
        addChild(cloud)
        
        // Remove cloud when it goes off screen
        let removeCloud = SKAction.sequence([
            SKAction.wait(forDuration: duration),
            SKAction.run {
                if !self.isPaused {
                    self.scoreUpdateHandler?()
                }
            },
            SKAction.removeFromParent()
            
        ])
        cloud.run(removeCloud)
        
    }
    
    func startGame() {
        self.isPaused = false
        
        // Spawn clouds
        let spawnClouds = SKAction.run { self.spawnCloud() }
        let delay = SKAction.wait(forDuration: 1.5)
        let spawnSequence = SKAction.sequence([spawnClouds, delay])
        run(SKAction.repeatForever(spawnSequence), withKey: "spawningClouds")
    
    }
    func setThunderPosition(for size: CGSize) {
        thunder.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 + 200)
    }
    

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isGameOver else { return }
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
        self.removeAction(forKey: "spawningClouds")
        isGameOver = true
        gameOverHandler?()
    }
    
    func restartGame() {
        // Remove all children except the thunder and score label
        print("restart2")
        self.removeAllChildren()
        thunder = SKSpriteNode(imageNamed: thunderName)
        thunder.size = CGSize(width: 28, height: 70)
        thunder.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 + shiftUp)
        thunder.physicsBody = SKPhysicsBody(rectangleOf: thunder.size)
        thunder.physicsBody?.isDynamic = false
        thunder.physicsBody?.categoryBitMask = thunderCategory
        thunder.physicsBody?.contactTestBitMask = cloudCategory
        thunder.physicsBody?.collisionBitMask = 0
        
        addChild(thunder)
        isGameOver = false
//        // Restart the game
       startGame()
    }
}

extension GameScene: GameSceneDelegate {
    func pause() {
        self.isPaused = true
    }
    
    func resume() {
        self.isPaused = false
    }
    
    func restart() {
        print("restart")
        restartGame()
    }
}
