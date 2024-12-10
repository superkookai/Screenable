//
//  ScreenableApp.swift
//  Screenable
//
//  Created by Weerawut Chaiyasomboon on 9/12/2567 BE.
//

import SwiftUI

@main
struct ScreenableApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: ScreenableDocument()){ file in
            ContentView(document: file.$document)
        }
        .windowResizability(.contentSize)
        .commands {
            CommandGroup(after: .saveItem) {
                Button("Export…") {
                    NSApp.sendAction(#selector(AppCommands.export), to: nil, from: nil)
                }
                .keyboardShortcut("e")
            }
        }
        .commands {
            CommandMenu("Export") {
                Button("Export as PNG") {
                    NSApp.sendAction(#selector(AppCommands.export), to: nil, from: nil)
                }
                .keyboardShortcut("e")
            }
        }
    }
}

@objc protocol AppCommands {
    func export()
}
