//
//  PlayerView.swift
//  Music Player
//
//  Created by JoeShon Monroe on 3/2/21.
//

import SwiftUI
import UIKit
import AVKit

/**
 Shows the current song playing, current time, and player controls.
 */
struct PlayerView: View {
    
    @Binding var miniPlayerOpacity:Double
        
    @Binding var song:Song? 
    
    @Binding var isPlaying:Bool
    
    @Binding var currentTime:String
    @Binding var timeLeft:String
    
    @Binding var progress:Double
    
    @State var minimize:(Bool) -> ()
    @State var playToggle:() -> ()
    @State var previous:() -> ()
    @State var next:() -> ()
    
    
    
    
    var body: some View {
        
        GeometryReader { reader in
            ZStack {
                Color.white.opacity(0.9)
                
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(Color.clear)
                        
                        VStack {
                            ProgressBarView(percentage: $progress)
                                .frame(height: 4)
                                //.padding(.bottom, 5)
                            
                            HStack {
                                Image(uiImage: getImage(name: song?.artwork ?? ""))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40, alignment: .center)
                                    .cornerRadius(5)
                                    .onTapGesture {
                                        minimize(false)
                                    }
                                
                                VStack(alignment: .leading) {
                                    Text(song?.title ?? "")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    
                                    Text(song?.artist ?? "")
                                        .font(.caption)
                                        .foregroundColor(.black)
                                }
                                .onTapGesture {
                                    minimize(false)
                                }
                                
                                Spacer()
                                    .onTapGesture {
                                        minimize(false)
                                    }
                                
                                Button {
                                    playToggle()
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 28)
                                            .fill(Color(.sRGB, red: 108/255, green: 99/255, blue: 255/255, opacity: 1))
                                            .frame(width: 40, height: 40, alignment: .center)
                                        if isPlaying {
                                            Image(systemName: "pause.fill")
                                                .foregroundColor(.white)
                                        } else {
                                            Image(systemName: "play.fill")
                                                .foregroundColor(.white)
                                                .offset(x: 1, y: 0)
                                        }
                                        
                                    }
                                    
                                }
                            }
                            
                        }
                        .padding()
                    }
                    .frame(height: 60)
                    
                    Spacer()
                }
                .opacity(miniPlayerOpacity)
                
                
                
                ZStack {
                    Image(uiImage: getImage(name: song?.artwork ?? ""))
                        .resizable()
                        .scaledToFill()
                        .blur(radius: 5, opaque: true)
                        .frame(maxWidth: reader.size.width)
                    
                    Color.white.opacity(0.9)
                    
                    VStack {
                        Image(uiImage: getImage(name: song?.artwork ?? ""))
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: 250, maxWidth: 285, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(20)
                            .padding(.bottom, 20)
                            .shadow(color: Color.black.opacity(0.7), radius: 20, x: 0, y: 10)
                        
                        
                        Text(song?.title ?? "")
                            .font(.headline)
                            .foregroundColor(.black)
                            .textCase(.uppercase)
                            .padding(.bottom, 3)
                        
                        Text(song?.artist ?? "")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding(.bottom, 10)
                        
                        ProgressBarView(percentage: $progress)
                            .frame(height: 8)
                            .padding(.bottom, 5)
                        
                        HStack {
                            Text(currentTime)
                                .font(.caption)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Text(timeLeft)
                                .font(.caption)
                                .foregroundColor(.black)
                        }
                        
                        HStack(alignment: .center) {
                            
                            
                            Button {
                                previous()
                            } label: {
                                Image("prev")
                            }
                            
                            Button {
                                playToggle()
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 28)
                                        .fill(Color(.sRGB, red: 108/255, green: 99/255, blue: 255/255, opacity: 1))
                                        .frame(width: 64, height: 64, alignment: .center)
                                    
                                    if isPlaying {
                                        Image(systemName: "pause.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20)
                                            .foregroundColor(.white)
                                    } else {
                                        Image(systemName: "play.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20)
                                            .foregroundColor(.white)
                                            .offset(x: 2, y: 0)
                                    }
                                }
                                
                            }
                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                            
                            Button {
                                next()
                            } label: {
                                Image("next")
                            }
                            
                        }
                    }
                    
                    .padding()
                    
                }
                
                .opacity(miniPlayerOpacity < 1 ? 1 - miniPlayerOpacity : 0)
            }
            .edgesIgnoringSafeArea(.all)
        }
        
    }
    
    func getImage(name:String) -> UIImage {
        return UIImage(imageLiteralResourceName: name)
    }
    
    
}


