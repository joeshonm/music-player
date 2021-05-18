//
//  ContentView.swift
//  Music Player
//
//  Created by JoeShon Monroe on 2/25/21.
//

import SwiftUI
import AVKit

/**
    The home view of the application.
 */
struct ContentView: View {
    
    /// The view model that supplies the view data.
    @ObservedObject private var viewModel = HomeViewModel()
    
    /// Boolean to toggle the showing of the music player
    @State private var showPlayer = false
    
    /// Boolean to toggle minimizing the music player
    @State private var minimized = false
    
    /// The player position inside the view as CGSize
    @State private var playerPosition = CGSize.zero
    
    /// The opacity of the minimized player as a Double
    @State private var miniPlayerOpacity = 0.0
    
    /// The current song playing
    @State private var currentSong:Song?
    
    /// The current song index in the view model array of songs
    @State private var currentSongIndex:Int = 0
    
    /// The class that handles the player functionality
    @ObservedObject private var player = Player()
    
    
    var body: some View {
        
        NavigationView {
            GeometryReader { reader in
                ZStack {
                    Color.white
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(alignment: .leading) {
                        Text("Songs")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                        
                        ScrollView {
                            LazyVStack(alignment: .leading) {
                                ForEach(viewModel.songs) { song in
                                    SongListItemView(song: song)
                                        .padding(.bottom, 10)
                                        .onTapGesture {
                                            
                                            currentSong = song
                                            
                                            currentSongIndex = viewModel.songs.firstIndex{$0 == song} ?? 0
                                            
                                            player.loadSong(play: song)
                                            
                                            if !showPlayer {
                                                playerPosition = CGSize(width: 0, height: reader.size.height)
                                                showPlayer = true
                                                
                                                withAnimation(.linear(duration: 0.2)) {
                                                    playerPosition = CGSize(width: 0, height: 0)
                                                }
                                                
                                            }
                                            
                                            
                                            
                                        }
                                }
                            }
                            .padding(EdgeInsets(top: 0, leading: 19, bottom: 60, trailing: 19))
                        }
                    }
                    
                    if showPlayer {
                        PlayerView(
                            miniPlayerOpacity: $miniPlayerOpacity,
                            song: $currentSong,
                            isPlaying: $player.isPlaying,
                            currentTime: $player.currentTime,
                            timeLeft: $player.timeLeft,
                            progress: $player.progress,
                            minimize: { min in
                                if min {
                                    miniPlayerOpacity = 1
                                    self.playerPosition = CGSize(width: 0, height: reader.size.height - 60)
                                    minimized = true
                                } else {
                                    self.playerPosition = CGSize.zero
                                    miniPlayerOpacity = 0
                                    minimized = false
                                }
                            },
                            playToggle: {
                                player.playToggle()
                            },
                            previous: {
                                previousSong()
                            },
                            next: {
                                nextSong()
                            }
                            
                        )
                        .opacity(showPlayer ? 1 : 0)
                        .offset(playerPosition)
                        .animation(.linear(duration: 0.2))
                        .gesture(DragGesture()
                                    .onChanged({ ( value ) in
                                        
                                        let opacity = roundOpacity(number: Double((value.translation.height - reader.size.height/1.25) / (reader.size.height - 60)))
                                        
                                        if value.translation.height > 0 {
                                            self.playerPosition = CGSize(width: 0, height: value.translation.height)
                                            
                                            miniPlayerOpacity = opacity * 6.5
                                        }
                                        
                                    })
                                    .onEnded({ ( value ) in
                                        
                                        if value.translation.height > (reader.size.height/4) {
                                            miniPlayerOpacity = 1
                                            self.playerPosition = CGSize(width: 0, height: reader.size.height - 60)
                                            minimized = true
                                        } else {
                                            self.playerPosition = CGSize.zero
                                            miniPlayerOpacity = 0
                                            minimized = false
                                        }
                                        
                                    }))
                        .animation(.linear(duration: 0.3))
                        .frame(maxWidth: reader.size.width)
                        
                    }
                    
                    
                    
                    
                }
            }
            
            .navigationBarHidden(true)
            .colorScheme(.light)
            
        }
        
        
        
        .onAppear {
            viewModel.loadSongs()
            
            player.finishedPlaying = {
                nextSong()
            }
            
        }
    }
    
    /// The rounded opacity of the player as the user drags the view
    /// - Parameter number: The raw opacity as a Double
    /// - Returns: The opacity as a double
    func roundOpacity(number:Double) -> Double {
        return Double(round(1000*number)/1000)
    }
    
    /// Advance to the previous song
    func previousSong() {
        currentSongIndex -= 1
                
        if currentSongIndex < 0 {
            currentSong = viewModel.songs[viewModel.songs.count-1]
            
            currentSongIndex = viewModel.songs.count-1
        } else {
            currentSong = viewModel.songs[currentSongIndex]
        }
                
        player.loadSong(play: currentSong!)
    }
    
    /// Advance to the next song
    func nextSong() {
        currentSongIndex += 1
        
        if currentSongIndex > viewModel.songs.count-1 {
            currentSong = viewModel.songs[0]
            currentSongIndex = 0
        } else {
            currentSong = viewModel.songs[currentSongIndex]
        }
                
        player.loadSong(play: currentSong!)
    }
    
    
    
    
    
    
}
