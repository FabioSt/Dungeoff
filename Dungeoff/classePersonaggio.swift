//
//  classePersonaggio.swift
//  Dungeoff
//
//  Created by Davide Russo on 18/11/2019.
//  Copyright © 2019 Fabio Staiano. All rights reserved.
//

import UIKit
import SpriteKit

class classePersonaggio: SKSpriteNode {
//        init() {
            
            let eroe = SKSpriteNode(imageNamed: "hero-idle1")
            var vita: Int = 3
            var died = false
//        }
    
    func die(){
        if (vita == 0){
            print("you died")
            died = true
        }
    }
}
