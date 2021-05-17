//
//  HomeViewModel.swift
//  Music Player
//
//  Created by JoeShon Monroe on 2/25/21.
//

import Foundation
import UIKit

class HomeViewModel: ObservableObject {
    
    @Published var songs:[Song] = []
    
    func loadSongs() {
        songs = Bundle.main.decodeJSON(file: "songs.json")
    }
    
    
}



