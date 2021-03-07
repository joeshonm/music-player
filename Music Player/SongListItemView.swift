//
//  SongListItemView.swift
//  Music Player
//
//  Created by JoeShon Monroe on 3/2/21.
//

import SwiftUI

struct SongListItemView: View {
    
    @State var song:Song
    
    var body: some View {
        VStack {
            HStack {
                Image(uiImage: UIImage(imageLiteralResourceName: song.artwork))
                    .resizable()
                    .frame(width: 78, height: 78, alignment: .center)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.16), radius: 30, x: 0, y: 15)
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading) {
                    Text(song.title)
                        .font(.headline)
                        .padding(.bottom, 2)
                    Text(song.artist)
                        .font(.subheadline)
                }
                
                Spacer()
            }
            
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1)
                .padding(.top, 10)
        }
        
        .frame(maxWidth: .infinity)
        .background(
            Rectangle()
                .fill(Color.white)
        )
        
    }
}

