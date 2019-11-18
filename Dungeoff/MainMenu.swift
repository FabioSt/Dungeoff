//
//  MainMenu.swift
//  Dungeoff
//
//  Created by Fabio Staiano on 18/11/2019.
//  Copyright © 2019 Fabio Staiano. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    
    // you can use another font for the label if you want...
    let tapStartLabel = SKLabelNode(fontNamed: "Helvetica")
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        // set the background
        backgroundColor = SKColor.white

        // set size, color, position and text of the tapStartLabel
        tapStartLabel.fontSize = 16
        tapStartLabel.fontColor = SKColor.black
        tapStartLabel.horizontalAlignmentMode = .center
        tapStartLabel.verticalAlignmentMode = .center
        tapStartLabel.position = CGPoint(
            x: size.width / 2,
            y: size.height / 2
        )
        tapStartLabel.text = "Tap to start the game"

        // add the label to the scene
        addChild(tapStartLabel)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(fileNamed: "Map")
        
        gameScene?.scaleMode = SKSceneScaleMode.aspectFill

        // use a transition to the gameScene
        let reveal = SKTransition.flipVertical(withDuration: 1.5)

        // transition from current scene to the new scene
        view!.presentScene(gameScene!, transition: reveal)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
}
