

import SpriteKit

protocol GameSceneDelegate: AnyObject {
    func restart()
    func pause()
    func resume()
    func stopSound()
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    let settings = SettingsModel()
    
    var duration: Double {
        return UIDevice.current.orientation.isPortrait ? 4 : 2
    }
    
    var shiftUp: Double = 50
    
    var scoreUpdateHandler: (() -> Void)?
    var gameOverHandler: (() -> Void)?
    var bonusUpdateHandler: (() -> Void)?
    var bonusResetHandler: (() -> Void)?
    
    var isGameOver = false
    var isInvulnerable = false
    // Categories for collision detection
    let thunderCategory: UInt32 = 0x1 << 0
    let cloudCategory: UInt32 = 0x1 << 1
    let shieldBonusCategory: UInt32 = 0x1 << 2
    let sphereBonusCategory: UInt32 = 0x1 << 3
    var thunderPosition = UIScreen.main.bounds.width / 2
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
        let cloudNumber = Int.random(in: 1...6)
        let cloud = SKSpriteNode(imageNamed: "cloud\(cloudNumber)")
        cloud.name = "cloud"
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
    }
    var sphere: SKSpriteNode!
    var shield: SKSpriteNode!
    
    var delayNumberSphere = Int.random(in: 20...60)
    var delayNumberShield = Int.random(in: 20...60)
    
    
    func spawnSphere() {
        sphere = SKSpriteNode(imageNamed: "sphere")
        sphere.name = "sphere"
        sphere.size = CGSize(width: 50, height: 50)
        sphere.position = CGPoint(x: CGFloat.random(in: 0...self.size.width), y: 0)
        sphere.physicsBody = SKPhysicsBody(rectangleOf: sphere.size)
        sphere.physicsBody?.isDynamic = true
        sphere.physicsBody?.affectedByGravity = false
        sphere.physicsBody?.categoryBitMask = sphereBonusCategory
        sphere.physicsBody?.contactTestBitMask = thunderCategory
        sphere.physicsBody?.collisionBitMask = 0
        sphere.physicsBody?.velocity = CGVector(dx: 0, dy: 250)
        sphere.physicsBody?.linearDamping = 0
        addChild(sphere)
        
    }
    
    func removeSphere() {
        let removeSphere = SKAction.sequence([
            SKAction.run {
                if !self.isPaused {
                    self.bonusUpdateHandler?()
                }
            },
            
            SKAction.removeFromParent()
            
        ])
        sphere.run(removeSphere)
        
        thunderPosition = thunder.position.x
        
    }
    
    func spawnShield() {
        
        shield = SKSpriteNode(imageNamed: "shieldBonus")
        shield.name = "shield"
        shield.size = CGSize(width: 50, height: 50)
        shield.position = CGPoint(x: CGFloat.random(in: 0...self.size.width), y: 0)
        shield.physicsBody = SKPhysicsBody(rectangleOf: sphere.size)
        shield.physicsBody?.isDynamic = true
        shield.physicsBody?.affectedByGravity = false
        shield.physicsBody?.categoryBitMask = shieldBonusCategory
        shield.physicsBody?.contactTestBitMask = thunderCategory
        shield.physicsBody?.collisionBitMask = 0
        shield.physicsBody?.velocity = CGVector(dx: 0, dy: 250)
        shield.physicsBody?.linearDamping = 0
        addChild(shield)
        
    }
    
    func removeShield() {
        let removeShield = SKAction.sequence([
            SKAction.run {
                if !self.isPaused {
                    
                }
            },
            
            SKAction.removeFromParent()
            
        ])
        shield.run(removeShield)
        
        thunderPosition = thunder.position.x
        
    }
    
    func startGame() {
        self.isPaused = false
        
        // Spawn clouds
        let spawnClouds = SKAction.run { self.spawnCloud() }
        let delay = SKAction.wait(forDuration: 1.5)
        let spawnSequence = SKAction.sequence([spawnClouds, delay])
        run(SKAction.repeatForever(spawnSequence), withKey: "spawningClouds")
        
        
        let spawnSphere = SKAction.run { self.spawnSphere() }
        let delaySphere = SKAction.wait(forDuration: TimeInterval(delayNumberSphere))
        let spawnSequenceSphere = SKAction.sequence([spawnSphere, delaySphere])
        run(SKAction.repeatForever(spawnSequenceSphere), withKey: "spawningSphere")
        
        let spawnShield = SKAction.run { self.spawnShield() }
        let delayShield = SKAction.wait(forDuration: TimeInterval(delayNumberShield))
        let spawnSequenceShield = SKAction.sequence([spawnShield, delayShield])
        run(SKAction.repeatForever(spawnSequenceShield), withKey: "spawningShield")
        
    }
    
    func setThunderPosition() {
        thunder.position = CGPoint(x: thunderPosition, y: UIScreen.main.bounds.height / 2 + shiftUp)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        // Удаляем облака, которые вышли за пределы экрана
        for node in children {
            if node.position.y > self.size.height + node.frame.height {
                if node.name == "cloud" {
                    print("cloud removed")
                    if !self.isPaused {
                        self.scoreUpdateHandler?()
                    }
                    
                    node.removeFromParent()
                }
                
                if node.name == "shield" {
                    print("shield removed")
                    node.removeFromParent()
                }
                
                if node.name == "sphere" {
                    print("sphere removed")
                    if !self.isPaused {
                        self.bonusResetHandler?()
                        if !self.isInvulnerable {
                            DispatchQueue.main.async {
                                
                                self.changeLightningAppearance(name: self.thunderName)
                                
                            }
                        }
                        
                    }
                    node.removeFromParent()
                }
            }
        }
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
        if (contact.bodyA.categoryBitMask == thunderCategory && contact.bodyB.categoryBitMask == cloudCategory) ||
            (contact.bodyA.categoryBitMask == cloudCategory && contact.bodyB.categoryBitMask == thunderCategory) {
            if !isInvulnerable {
                if settings.soundEnabled {
                    playSound(named: "gameOver")
                }
                gameOver()
            } else {
                isInvulnerable = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.changeLightningAppearance(name: self.thunderName)
                   
                }
                
            }
        }
        
        // Handle collision between thunder and sphere
        if (contact.bodyA.categoryBitMask == thunderCategory && contact.bodyB.categoryBitMask == sphereBonusCategory) ||
            (contact.bodyA.categoryBitMask == sphereBonusCategory && contact.bodyB.categoryBitMask == thunderCategory) {
            // Bonus effect
            print("Bonus collected!")
            if settings.soundEnabled {
                playSound(named: "sphere")
            }
            self.changeLightningAppearance(name: "sphereLight")
            
            removeSphere()
            
        }
        
        if (contact.bodyA.categoryBitMask == thunderCategory && contact.bodyB.categoryBitMask == shieldBonusCategory) ||
            (contact.bodyA.categoryBitMask == shieldBonusCategory && contact.bodyB.categoryBitMask == thunderCategory) {
            // Bonus effect
            print("Shield collected!")
            if settings.soundEnabled {
                playSound(named: "shield")
            }
            changeLightningAppearance(name: "shieldLight")
            
            isInvulnerable = true
            removeShield()
            
            
        }
    }
    
    func changeLightningAppearance(name: String) {
        let newTexture = SKTexture(imageNamed: name) // The new texture
        thunder.texture = newTexture
        
        // Rescale the node to match the new texture while maintaining its current size
        let aspectRatio = newTexture.size().width / newTexture.size().height
        let newHeight = thunder.size.height
        let newWidth = newHeight * aspectRatio
        thunder.size = CGSize(width: newWidth, height: newHeight)
    }
    
    func gameOver() {
        // Stop the scene and display Game Over
        self.isPaused = true
        self.removeAction(forKey: "spawningClouds")
        self.removeAction(forKey: "spawningSphere")
        isGameOver = true
        gameOverHandler?()
    }
    
    func addThunder(name: String, size: CGSize) {
        thunder = SKSpriteNode(texture: SKTexture(imageNamed: name))
        thunder.size = size
        thunder.position.y = UIScreen.main.bounds.height / 2 + shiftUp
        thunder.physicsBody = SKPhysicsBody(rectangleOf: size)
        thunder.physicsBody?.isDynamic = false
        thunder.physicsBody?.categoryBitMask = thunderCategory
        thunder.physicsBody?.contactTestBitMask = cloudCategory
        thunder.physicsBody?.collisionBitMask = 0
        
        addChild(thunder)
    }
    
    func restartGame() {
        // Remove all children except the thunder and score label
        print("restart2")
        self.removeAllChildren()
        addThunder(name: thunderName, size: CGSize(width: 28, height: 70))
        thunder.position.x = UIScreen.main.bounds.width / 2
        isGameOver = false
        //        // Restart the game
        startGame()
    }
    
    func playSound(named name: String) {
        run(SKAction.playSoundFileNamed(name, waitForCompletion: false))
        
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
    
    func stopSound() {
        run(SKAction.stop())
        
    }
}
