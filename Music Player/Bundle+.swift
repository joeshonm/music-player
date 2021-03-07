//
//  Bundle+.swift
//  Music Player
//
//  Created by JoeShon Monroe on 2/28/21.
//

import Foundation

extension Bundle {
    
    
    
    func decodeJSON<T: Codable>(file:String) -> T {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) into json.")
        }
        
        return loaded
    }
}
