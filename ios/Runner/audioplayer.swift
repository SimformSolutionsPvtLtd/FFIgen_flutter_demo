//
//  audioplayer.swift
//  Runner
//
//  Created by Janak Mistry on 10/02/23.
//

import Foundation

import AVKit

@objc public class AudioPlayer: NSObject {
    @objc public var player: AVAudioPlayer?
    @objc public func play(path: String){
        let audioUrl = URL.init(string: path)

        if(audioUrl == nil){
            print("Something went wrong!!")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: audioUrl!)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Something went wrong!!")
        }
    }

    @objc public func stopAudio(){
        player?.stop()
       player = nil
    }
}
