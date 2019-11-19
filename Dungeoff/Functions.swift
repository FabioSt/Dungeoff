//
//  Functions.swift
//  Dungeoff
//
//  Created by Fabio Staiano on 18/11/2019.
//  Copyright © 2019 Fabio Staiano. All rights reserved.
//

import AVFoundation
import SpriteKit


// Dash - Sound Effect
func dashSound() {
var audioPlayer = AVAudioPlayer()
let soundURL = Bundle.main.url(forResource: "dash", withExtension: "wav")
do {
    audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
}
catch {
    print(error)
}
audioPlayer.play()
}
