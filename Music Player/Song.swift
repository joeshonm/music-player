//
//  Song.swift
//  Music Player
//
//  Created by JoeShon Monroe on 2/28/21.
//

import SwiftUI

struct Song: Codable, Identifiable, Equatable {
    var id = UUID()
    var title:String = ""
    var artist:String = ""
    var album:String = ""
    var artwork:String = ""
    var file:String = ""
        
    enum CodingKeys: CodingKey {
        case title, artist, album, artwork, file
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        artist = try container.decode(String.self, forKey: .artist)
        album = try container.decode(String.self, forKey: .album)
        artwork = try container.decode(String.self, forKey: .artwork)
        file = try container.decode(String.self, forKey: .file)
    }
    
    
}
