//
//  SoundPlayer.swift
//  GPStest
//
//  Created by sakurai sumika on 2024/09/26.
//

import UIKit
import AVFoundation

class SoundPlayer: NSObject {
    
    var music_player:AVAudioPlayer!
    
    // 音楽を再生00.
    func musicPlayer(source: String, vol: Float){
        let Track = NSDataAsset(name: source)!.data   // 音源の指定
        
        do{
            music_player = try AVAudioPlayer(data:Track)   // 音楽を指定
            music_player.numberOfLoops = 0
            music_player.volume = vol
            music_player.play()   // 音楽再生
        }catch{
            print("エラー発生.音を流せません")
        }
    }
    // 音楽を停止
    func stopAllMusic (){
        music_player?.stop()
    }
}


