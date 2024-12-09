//
//  RenderView.swift
//  Screenable
//
//  Created by Weerawut Chaiyasomboon on 9/12/2567 BE.
//

import SwiftUI

struct RenderView: View {
    let document: ScreenableDocument
    
    var body: some View {
        Canvas { context, size in
            // set up
            let fullSizeRect = CGRect(origin: .zero, size: size)
            let fullSizePath = Path(fullSizeRect)
            let phoneSize = CGSize(width: 300, height: 607)
            let imageInsets = CGSize(width: 16, height: 14)
            
            // draw the background image
            context.fill(fullSizePath, with: .color(.white))
            if document.backgroundImage.isEmpty == false {
                context.draw(Image(document.backgroundImage), in: fullSizeRect)
            }
            // add a gradient
            
            // draw the caption
            var verticalOffset = 0.0
            let horizontalOffset = (size.width - phoneSize.width) / 2
            
            if document.caption.isEmpty {
                verticalOffset = (size.height - phoneSize.height) / 2
            } else {
                // more code to come
                if let resolvedCaption = context.resolveSymbol(id: "Text") {
                    // center the text
                    let textPosition = (size.width - resolvedCaption.size.width) / 2
                    
                    // draw it 20 points from the top
                    context.draw(resolvedCaption, in: CGRect(origin: CGPoint(x: textPosition, y: 20), size: resolvedCaption.size))
                    
                    // use the text height + 20 before the text + 20 after the text for verticalOffset
                    verticalOffset = resolvedCaption.size.height + 40
                }
            }
            
            if let screenshot = context.resolveSymbol(id: "Image") {
                // more code to come
                let drawPosition = CGPoint(x: horizontalOffset + imageInsets.width, y: verticalOffset + imageInsets.height)
                let drawSize = CGSize(width: phoneSize.width - imageInsets.width * 2, height: phoneSize.height - imageInsets.height * 2)
                context.draw(screenshot, in: CGRect(origin: drawPosition, size: drawSize))
            }
            
            // draw the phone
            context.draw(Image("iPhone"), in: CGRect(origin: CGPoint(x: horizontalOffset, y: verticalOffset), size: phoneSize))
            
        } symbols: {
            // add custom SwiftUI views
            Text(document.caption)
                .font(.custom(document.font, size: Double(document.fontSize)))
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .tag("Text")
            
            if let userImage = document.userImage, let nsImage = NSImage(data: userImage) {
                Image(nsImage: nsImage)
                    .tag("Image")
            }else{
                Color.gray
                    .tag("Image")
            }
        }
        .frame(width: 414, height: 736)
    }
    
    static var previews: some View {
        var document = ScreenableDocument()
        document.caption = "Hello, world"
        
        return RenderView(document: document)
    }
}

#Preview {
    RenderView.previews
}
