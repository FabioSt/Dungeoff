//
//  Functions.swift
//  Dungeoff
//
//  Created by Fabio Staiano on 18/11/2019.
//  Copyright © 2019 Fabio Staiano. All rights reserved.
//

import SpriteKit
import AVFoundation


func dashSound() {
       if let soundURL = Bundle.main.url(forResource: "dash", withExtension: "wav") {
           var mySound: SystemSoundID = 0
           AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
           AudioServicesPlaySystemSound(mySound);
       }
   }

func hitSound() {
       if let soundURL = Bundle.main.url(forResource: "hit", withExtension: "wav") {
           var mySound: SystemSoundID = 0
           AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
           AudioServicesPlaySystemSound(mySound);
       }
   }
