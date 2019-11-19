//
//  GameScene.swift
//  Dungeoff
//
//  Created by Fabio Staiano on 05/11/2019.
//  Copyright © 2019 Fabio Staiano. All rights reserved.


import SpriteKit
// this code is crazyyyyyyy
var rockMap : SKTileMapNode = SKTileMapNode()
var waterMap : SKTileMapNode = SKTileMapNode()
var currentRow = rockMap.numberOfColumns/2
var currentColumn = rockMap.numberOfRows/2 + 1
var moveVector = CGVector(dx: 0, dy: 0)

let skeletonHP = CGFloat(6)
var hitCounter = CGFloat(0)
let tileSet = rockMap.tileSet

var heartContainers = SKSpriteNode(imageNamed: "3of3")

var coinCounter:Int = 0

class GameScene: SKScene {
    
    var label = SKLabelNode(fontNamed: "Savior4")
    let skeletonNode = SKSpriteNode(imageNamed: "skeleton1")
    var lifeBar = SKSpriteNode(texture: nil)
    let cameraNode = SKCameraNode()
    let coinNode = SKSpriteNode(imageNamed: "coin")
    let heroNode: classePersonaggio = classePersonaggio.init()
    let mapImage = UIImageView(frame: UIScreen.main.bounds)
    
    let walkableTiles = ["B2", "B3", "A2"]
    
    func checkPositions() {
        if comparePositionRound(position1: heroNode.position, position2: skeletonNode.position) {
            //            attack(targetPosition: skeletonNode.position)
            bump(node: heroNode, arrivingDirection: moveVector)
            checkHP()
            print("move Vector is \(moveVector)")
        } else if comparePositionRound(position1: heroNode.position, position2: coinNode.position) {
            if coinNode.parent != nil {
                coinCounter += 1
                coinNode.removeFromParent()
                print(coinCounter)
                label.text = "\(coinCounter)"
            }
        }
    }
    
    override func update(_ currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
        camera!.position = heroNode.position
        checkPositions()
        label.text = "\(coinCounter)"
        if lifeBar.size.width == .zero {
        lifeBar.removeFromParent()
            skeletonNode.run(.fadeAlpha(to: 0, duration: 0.8))
        }
    }
    
    func checkHP(){
        if lifeBar.size.width == .zero {
            lifeBar.removeFromParent()
            skeletonNode.run(.fadeAlpha(to: 0, duration: 1))
            coinCounter += 100
//            skeletonNode.removeFromParent()
            return
        }
        hitCounter += 1
        let newSize = CGSize(width: skeletonNode.size.width - skeletonNode.size.width * hitCounter/skeletonHP, height: skeletonNode.size.height/5)
        print("\(hitCounter) / \(skeletonHP)")
//        lifeBar.size = newSize
        print("\(hitCounter/skeletonHP)")
        lifeBar.run(.resize(toWidth: newSize.width, duration: 0.5))
    }
    
    func heroRun() {
        // hero frames
         let herof0 = SKTexture.init(imageNamed: "hero-run1")
         let herof1 = SKTexture.init(imageNamed: "hero-run2")
         let herof2 = SKTexture.init(imageNamed: "hero-run3")
         let heroFrames: [SKTexture] = [herof0, herof1, herof2]
        
         herof0.filteringMode = .nearest
         herof1.filteringMode = .nearest
         herof2.filteringMode = .nearest

         // Change the frame per 0.2 sec
         let animation = SKAction.animate(with: heroFrames, timePerFrame: 0.08)
        heroNode.run(SKAction.repeat(animation, count: 1))
    }
    
    func heroSpawn(){
        
         // hero frames
         let herof0 = SKTexture.init(imageNamed: "hero-idle1")
         let herof1 = SKTexture.init(imageNamed: "hero-idle2")
         let herof2 = SKTexture.init(imageNamed: "hero-idle3")
         let heroFrames: [SKTexture] = [herof0, herof1, herof2]
        
        
         herof0.filteringMode = .nearest
         herof1.filteringMode = .nearest
         herof2.filteringMode = .nearest

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
        skeletonNode.position = rockMap.centerOfTile(atColumn: 14, row: 13)
        skeletonNode.size = CGSize(width: 64, height: 64)
        skeletonNode.texture?.filteringMode = .nearest
        
        let barSize = CGSize(width: skeletonNode.size.width, height: skeletonNode.size.height/5)
        lifeBar = SKSpriteNode(color: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), size: barSize)
        
        let lifeBarPosition = CGPoint(x: skeletonNode.position.x, y: skeletonNode.position.y + skeletonNode.size.height)
        lifeBar.position = lifeBarPosition
        self.addChild(lifeBar)
        
        // Change the frame per 0.2 sec
        let animation = SKAction.animate(with: skelFrames, timePerFrame: 0.2)
        skeletonNode.run(SKAction.repeatForever(animation))
        self.addChild(skeletonNode)
        
    }
    
    func coinSpawn(){
        
        coinNode.position = CGPoint(x: -170, y: 370)
         coinNode.size = CGSize(width: 32, height: 32)
         coinNode.texture?.filteringMode = .nearest
        coinNode.zPosition = 1000

       label.position = CGPoint(x: -145, y: 357)
        label.horizontalAlignmentMode = .left
       label.fontColor = SKColor.white
       label.fontSize = 55
       
         camera!.addChild(label)
         camera!.addChild(coinNode)

    }
    
    func hearts() {
            heartContainers.size = CGSize(width: 118, height: 30)
           heartContainers.position = CGPoint(x: -134, y: 325)
        camera!.addChild(heartContainers)
       }
    
    func attack(targetPosition: CGPoint) {
        let newPosition = CGPoint.init(x: (Int.random(in: -3...3)*Int(rockMap.tileSize.width)) + Int(targetPosition.x), y: (Int.random(in: -6...6) * Int(rockMap.tileSize.height)) + Int(targetPosition.y))
        
        let column = rockMap.tileColumnIndex(fromPosition: newPosition)
        let row = rockMap.tileRowIndex(fromPosition: newPosition)
        
        skeletonNode.position = rockMap.centerOfTile(atColumn: column, row: row)
    }
    
    func heartsDown() {
        if (heroNode.vita == 3) {
            heartContainers.texture = SKTexture(imageNamed: "3of3")
        } else if (heroNode.vita == 2) {
            heartContainers.texture = SKTexture(imageNamed: "2of3")
        } else if (heroNode.vita == 1) {
            heartContainers.texture = SKTexture(imageNamed: "1of3")
        }
    }
    
    func bump(node: SKNode, arrivingDirection: CGVector) {
        let bounceDestination = CGPoint(x: -arrivingDirection.dx, y: -arrivingDirection.dy)
//        node.run(.move(to: bounceDestination, duration: 0.1))
        node.run(.moveBy(x: bounceDestination.x, y: bounceDestination.y, duration: 0.1))
        heroNode.vita -= 1
        heartsDown()
        heroNode.die()
        print(heroNode.vita)
        if (heroNode.died == true){
            gameOver()
            scene?.view?.isPaused = true
        }
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
                let newPosition = CGPoint(x: heroNode.position.x + 64, y: heroNode.position.y)
                if onLand(characterPosition: newPosition, map: rockMap) == false { return }
                heroRun()
                heroNode.run(.move(by: .init(dx: 64, dy: 0), duration: 0.2))
                heroNode.xScale = 1.0;
                currentColumn += 1
                moveVector = .init(dx: 64, dy: 0)
                print("Gesture direction: Right")
                print("\(currentColumn) , \(currentRow)")
                print(heroNode.position)
            case .left:
                let newPosition = CGPoint(x: heroNode.position.x - 64, y: heroNode.position.y)
                if onLand(characterPosition: newPosition, map: rockMap) == false { return }
                heroRun()
                heroNode.run(.move(by: .init(dx: -64, dy: 0), duration: 0.2))
                heroNode.xScale = -1.0;
                currentColumn -= 1
                moveVector = .init(dx: -64, dy: 0)
                print("Gesture direction: Left")
                print("\(currentColumn) , \(currentRow)")
            print(heroNode.position)

            case .up:
                let newPosition = CGPoint(x: heroNode.position.x, y: heroNode.position.y + 64)
                if onLand(characterPosition: newPosition, map: rockMap) == false { return }
                heroNode.run(.move(by: .init(dx: 0, dy: 64), duration: 0.2))
//                heroNode.zRotation = 3.14 / 2
//                heroNode.position = rockMap.centerOfTile(atColumn: currentColumn, row: currentRow + 1)
                currentRow += 1
                moveVector = .init(dx: 0, dy: 64)
                print("Gesture direction: Up")
            print("\(currentColumn) , \(currentRow)")
            print(heroNode.position)

            case .down:
                let newPosition = CGPoint(x: heroNode.position.x, y: heroNode.position.y - 64)
                if onLand(characterPosition: newPosition, map: rockMap) == false { return }
                heroNode.run(.move(by: .init(dx: 0, dy: -64), duration: 0.2))
//                heroNode.position = rockMap.centerOfTile(atColumn: currentColumn , row: currentRow - 1)
                currentRow -= 1
                moveVector = .init(dx: 0, dy: -64)
                print("Gesture direction: Down")
            print("\(currentColumn) , \(currentRow)")
            print(heroNode.position)
            
            default:
                print("Unrecognized Gesture Direction")
        }
    }
    
    func onLand(characterPosition: CGPoint, map: SKTileMapNode) -> Bool {
        let column = map.tileColumnIndex(fromPosition: characterPosition)
        let row = map.tileRowIndex(fromPosition: characterPosition)
        
        if map.tileDefinition(atColumn: column, row: row)?.name != walkableTiles[0] { return false }
        else { return true }
        
//        map.tileDefinition(atColumn: column, row: row)
    }
    
    func comparePositionRound(position1: CGPoint, position2: CGPoint) -> Bool {
        if position1.x.rounded() == position2.x.rounded() && position1.y.rounded() == position2.y.rounded() {
            return true
        }
        else {
            return false
        }
    }
    
    func addMap() {
        mapImage.image = UIImage(named: "map")
        mapImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view?.insertSubview(mapImage, at: 0)
    }
    
    func gameOver() {
        removeAllChildren()
        removeAllActions()
        mapImage.image = UIImage(named: "gameOver")
        mapImage.contentMode = UIView.ContentMode.scaleAspectFit
        self.view?.insertSubview(mapImage, at: 0)
        
        
    }
    
   
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.init(red: 0.1647, green: 0.0745, blue: 0.1961, alpha: 1.0)
        addSwipe()
        camera!.setScale(1.2)
        
        // Function for apply PixelArt shit to the tiles
        for tileGroup in tileSet.tileGroups {
            for tileRule in tileGroup.rules {
                for tileDefinition in tileRule.tileDefinitions {
                    for texture in tileDefinition.textures {
                        texture.filteringMode = .nearest
                        tileDefinition.size = rockMap.tileSize
                    }
                }
            }
        }
        
        for node in self.children {
            if ( node.name == "rocks") {
                rockMap = node as! SKTileMapNode
            } else if ( node.name == "water"){
                waterMap = node as! SKTileMapNode
            }
        }
        

        
        heroSpawn()
        coinSpawn()
        skeletonSpawn()
        hearts()
        

       let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchFrom))
              view.addGestureRecognizer(pinchGesture)
        
    }
    
    @objc func handlePinchFrom(_ sender: UIPinchGestureRecognizer) {
        let pinch = SKAction.scale(by: sender.scale, duration: 0.0)
        camera!.run(pinch)
        sender.scale = 1.0
        print("x " , camera!.xScale)
        
        if (camera!.xScale > 3 ){
            addMap()
            mapImage.alpha = 1
        }else {mapImage.alpha = 0}
            
            if(camera!.xScale < 1){
            
            camera!.setScale(1.5)
        }
        
    }

}

