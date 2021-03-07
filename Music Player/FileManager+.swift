//
//  URL+.swift
//  Music Player
//
//  Created by JoeShon Monroe on 2/25/21.
//

import Foundation

extension FileManager {
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
}
