//
//  Bundle-StringArray.swift
//  Screenable
//
//  Created by Weerawut Chaiyasomboon on 9/12/2567 BE.
//

import Foundation

extension Bundle{
    
    func loadStringArray(from file: String) -> [String]{
        guard let url = self.url(forResource: file, withExtension: nil) else{
            fatalError("Failed to locate \(file) in bundle")
        }
        
        guard let string = try? String(contentsOf: url) else{
            fatalError("Failed to load \(file) in bundle")
        }
        
        return string.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
    }
}
