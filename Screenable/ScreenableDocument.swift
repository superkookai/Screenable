//
//  ScreenableDocument.swift
//  Screenable
//
//  Created by Weerawut Chaiyasomboon on 9/12/2567 BE.
//

import SwiftUI
import UniformTypeIdentifiers

struct ScreenableDocument: FileDocument, Codable {
    static var readableContentTypes = [UTType(exportedAs: "com.hackingwithswift.screenable")]
    
    var caption = ""
    var font = "Helvetica Neue"
    var fontSize = 16
    var backgroundImage = ""
    var userImage: Data?
    var captionColor = Color.black
    var backgroundColorTop = Color.clear
    var backgroundColorBottom = Color.clear
    var dropShadowLocation = 0
    var dropShadowStrength = 1
    
    init(){ }
    
    init(configuration: ReadConfiguration) throws{
        if let data = configuration.file.regularFileContents {
            self = try JSONDecoder().decode(ScreenableDocument.self, from: data)
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(self)
        return FileWrapper(regularFileWithContents: data)
    }
    
}

