//
//  GameScene.swift
//  Chinggu
//
//  Created by Sebin Kwon on 2023/08/31.
//

import SwiftUI
import SpriteKit
import CoreMotion

class GameScene: SKScene {
    @AppStorage("isCompliment") private var isCompliment = false
    var boxes: [SKSpriteNode] = []
    var complimentCount = 0
    let motionManager = CMMotionManager()
    var background = SKSpriteNode(imageNamed: "boxBackground")
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
            
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates(to: .main) { (motion, error) in
            guard let motion = motion else { return }
            let x = motion.gravity.x
            let y = motion.gravity.y
            self.physicsWorld.gravity = CGVector(dx: x * 35, dy: y * 35)
        }
        background.alpha = 0.45
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
 
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                for i in 0..<self.complimentCount {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 * Double(i)) {
                        self.addBox(at: CGPoint(x: UIScreen.main.bounds.width / 2,
                                                y: UIScreen.main.bounds.height / 2.5))
                    }
                }
            }
    }
    
    func addBox(at position: CGPoint) {
        // 이미지가 랜덤으로 나오는 것
        HapticManager.instance.notification(type: .warning)
        
        let index = Int.random(in: 1..<99)
        let texture = SKTexture(imageNamed: "stonery\(index)")
        let box = SKSpriteNode(texture: texture)
        let body = SKPhysicsBody(texture: texture, size: texture.size())
        box.position = position
        box.physicsBody = body
        addChild(box)
        boxes.append(box)
    }
    
    func resetBoxes() {
        for box in boxes {
            let fadeOut = SKAction.fadeOut(withDuration: 1.0)
            let remove = SKAction.removeFromParent()
            let removeFromArray = SKAction.run {
                if let index = self.boxes.firstIndex(of: box) {
                    self.boxes.remove(at: index)
                }
            }
            let sequence = SKAction.sequence([fadeOut, removeFromArray, remove])
            box.run(sequence)
        }
    }
}
