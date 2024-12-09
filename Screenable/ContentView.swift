//
//  ContentView.swift
//  Screenable
//
//  Created by Weerawut Chaiyasomboon on 9/12/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: ScreenableDocument
    let fonts = Bundle.main.loadStringArray(from: "Fonts.txt")
    let backgrounds = Bundle.main.loadStringArray(from: "Backgrounds.txt")
    
    var body: some View {
        HStack(spacing: 20) {
            RenderView(document: document)
                .dropDestination(for: URL.self) { items, location in
                    handleDrop(of: items)
                }
            
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Caption")
                        .bold()
                    TextEditor(text: $document.caption)
                        .font(.title)
                        .border(.tertiary, width: 1)
                    Picker("Select a caption font", selection: $document.font) {
                        ForEach(fonts, id:\.self) { font in
                            Text(font)
                        }
                    }
                    Picker("Size of caption font", selection: $document.fontSize) {
                        ForEach(Array(stride(from: 12, through: 72, by: 4)),id:\.self) { size in
                            Text("\(size)pt")
                        }
                    }
                }
                .labelsHidden()
                
                VStack(alignment: .leading){
                    Text("Background image")
                        .bold()
                    Picker("Background image", selection: $document.backgroundImage) {
                        Text("No background image").tag("")
                        Divider()
                        ForEach(backgrounds,id:\.self) { background in
                            Text(background)
                        }
                    }
                }
                .labelsHidden()
            }
            .frame(width: 250)
        }
        .padding()
    }
    
    func handleDrop(of urls: [URL]) -> Bool {
        guard let url = urls.first else { return false }
        let loadedImage = try? Data(contentsOf: url)
        document.userImage = loadedImage
        return true
    }
}

#Preview {
    ContentView(document: .constant(ScreenableDocument()))
}
