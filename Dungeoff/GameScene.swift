//
//  GameScene.swift
//  Dungeoff
//
//  Created by Fabio Staiano on 05/11/2019.
//  Copyright © 2019 Fabio Staiano. All rights reserved.


import SpriteKit

var rockMap : SKTileMapNode = SKTileMapNode()
var waterMap : SKTileMapNode = SKTileMapNode()
var currentRow = rockMap.numberOfColumns/2
var currentColumn = rockMap.numberOfRows/2

var coinCounter:Int = 0

class GameScene: SKScene {
    
    var label = SKLabelNode.init(text: "0")
    let heroNode = SKSpriteNode(imageNamed: "hero1")
    let skeletonNode = SKSpriteNode(imageNamed: "skeleton1")
    let cameraNode = SKCameraNode()
    let coin = SKSpriteNode(imageNamed: "coin")
    
    func checkPositions() {
        if heroNode.position == skeletonNode.position {
                          attack()
        } else if (heroNode.position == coin.position) {
                   coinCounter += 1
                    coin.removeFromParent()
                    print(coinCounter)
                    label.text = "\(coinCounter)"
               }
    }
    
    override func update(_ currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
        cameraNode.position = heroNode.position
        checkPositions()
    }
    
    func heroSpawn(){
        
         // 4 hero frames
         let herof0 = SKTexture.init(imageNamed: "hero1")
         let herof1 = SKTexture.init(imageNamed: "hero2")
         let herof2 = SKTexture.init(imageNamed: "hero3")
         let herof3 = SKTexture.init(imageNamed: "hero4")
         let heroFrames: [SKTexture] = [herof0, herof1, herof2, herof3]
        
        
         herof0.filteringMode = .nearest
         herof1.filteringMode = .nearest
         herof2.filteringMode = .nearest
         herof3.filteringMode = .nearest

         // Load the first frame as initialization
         heroNode.size = CGSize(width: 64, height: 64)
         heroNode.texture?.filteringMode = .nearest
         heroNode.position = rockMap.centerOfTile(atColumn: currentColumn , row: currentRow)

         // Change the frame per 0.2 sec
         let animation = SKAction.animate(with: heroFrames, timePerFrame: 0.2)
         heroNode.run(SKAction.repeatForever(animation))
        
        self.addChild(heroNode)
    }
    
    func skeletonSpawn(){

            // 4 skel frames
            let skelf0 = SKTexture.init(imageNamed: "skeleton1")
            let skelf1 = SKTexture.init(imageNamed: "skeleton2")
            let skelf2 = SKTexture.init(imageNamed: "skeleton3")
            let skelf3 = SKTexture.init(imageNamed: "skeleton4")
            let skelFrames: [SKTexture] = [skelf0, skelf1, skelf2, skelf3]
            skelf0.filteringMode = .nearest
            skelf1.filteringMode = .nearest
            skelf2.filteringMode = .nearest
            skelf3.filteringMode = .nearest

            // Load the first frame as initialization
            skeletonNode.position = rockMap.centerOfTile(atColumn: 15, row: 16)
            skeletonNode.size = CGSize(width: 64, height: 64)
            skeletonNode.texture?.filteringMode = .nearest

            // Change the frame per 0.2 sec
            let animation = SKAction.animate(with: skelFrames, timePerFrame: 0.2)
            skeletonNode.run(SKAction.repeatForever(animation))
            self.addChild(skeletonNode)

    
    }
    
    
    
    func coinSpawn(){
        
         coin.position = rockMap.centerOfTile(atColumn: 12, row: 13)
         coin.size = CGSize(width: 32, height: 32)
         coin.texture?.filteringMode = .nearest
         self.addChild(coin)


    }
    
    func attack() {
            skeletonNode.position = rockMap.centerOfTile(atColumn: 17, row: 18)
    }
    
    
    func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            gesture.direction = direction
            view?.addGestureRecognizer(gesture)// sel.view
        }
    }

    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        let direction = sender.direction
        switch direction {
            case .right:
                heroNode.position = rockMap.centerOfTile(atColumn: currentColumn + 1, row: currentRow)
//                heroNode.run(.move(by: .init(dx: 64, dy: 0), duration: 0.2))
                currentColumn += 1
                print("Gesture direction: Right")
                print("\(currentColumn) , \(currentRow)")
            case .left:
                heroNode.position = rockMap.centerOfTile(atColumn: currentColumn - 1, row: currentRow)
                currentColumn -= 1
                print("Gesture direction: Left")
                print("\(currentColumn) , \(currentRow)")
            case .up:
                heroNode.position = rockMap.centerOfTile(atColumn: currentColumn, row: currentRow + 1)
                currentRow += 1
                print("Gesture direction: Up")
            print("\(currentColumn) , \(currentRow)")
            case .down:
                heroNode.position = rockMap.centerOfTile(atColumn: currentColumn , row: currentRow - 1)
                currentRow -= 1
                print("Gesture direction: Down")
            print("\(currentColumn) , \(currentRow)")
            default:
                print("Unrecognized Gesture Direction")
        }
    }
    
    override func didMove(to view: SKView) {
        
        addSwipe()
        
        for node in self.children {
            if ( node.name == "rocks") {
                rockMap = node as! SKTileMapNode
            } else if ( node.name == "water"){
                waterMap = node as! SKTileMapNode
            }
        }
        

        label.position = CGPoint(x: view.frame.width / 4, y: view.frame.height / 4)
        label.fontColor = SKColor.yellow
        label.fontSize = 45
        label.fontName = "Helvetica"
        
        addChild(label)
        
        heroSpawn()
        coinSpawn()
        skeletonSpawn()

       
        
        addChild(cameraNode)
        camera = cameraNode
        
    }

}

