//
//  Player.swift
//  Music Player
//
//  Created by JoeShon Monroe on 3/6/21.
//

import Foundation
import AVKit
import SwiftUI

class Player: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    private var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    
    private var timer:Timer?
    
    var finishedPlaying:() -> () = {}
    
    @Published var isPlaying:Bool = false
    @Published var currentTime:String = "00:00"
    @Published var timeLeft:String = "-00:00"
    @Published var progress:Double = 0.0
  
    
    func loadSong(play song:Song) {
        
        guard let url = Bundle.main.url(forResource: song.file, withExtension: "mp3") else { return }
                
        do {
            let data = try Data(contentsOf: url)
            self.audioPlayer = try AVAudioPlayer(data: data)
            self.audioPlayer.delegate = self
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.play()
            
            isPlaying = audioPlayer.isPlaying
            
            toggleTimer()
            
            
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func playToggle() {
        
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        } else {
            audioPlayer.play()
        }
        
        isPlaying = audioPlayer.isPlaying
        
        toggleTimer()
        
    }
    
    func toggleTimer() {
        if audioPlayer.isPlaying {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                let (ct, tl) = self.getTime(seconds: self.audioPlayer.currentTime)
                self.currentTime = ct
                self.timeLeft = tl
            }
        } else {
            timer?.invalidate()
        }
    }
    
    func getTime (seconds : TimeInterval) -> (String, String) {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad

        let currentTimeFormatted = formatter.string(from: seconds)!
        let timeLeftFormatted = formatter.string(from: seconds - self.audioPlayer.duration)!
        
        self.progress = seconds / self.audioPlayer.duration
        
        
        
        return (currentTimeFormatted, timeLeftFormatted)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        finishedPlaying()
    }


    
}
