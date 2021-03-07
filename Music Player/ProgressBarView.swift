//
//  ProgressBarView.swift
//  Music Player
//
//  Created by JoeShon Monroe on 3/4/21.
//

import SwiftUI

struct ProgressBarView: View {
    
    @Binding var percentage:Double
    
    var body: some View {
        
        GeometryReader { reader in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: reader.size.height/2)
                    .fill(Color.white.opacity(0.5))
                    .frame(height: reader.size.height)
                
                RoundedRectangle(cornerRadius: reader.size.height/2)
                    .fill(Color(.sRGB, red: 108/255, green: 99/255, blue: 255/255, opacity: 1))
                    .frame(width: reader.size.width * CGFloat(percentage), height: reader.size.height)
                
                
                
            }
        }
        
    }
}
