//
//  Cardify.swift
//  Memorize
//
//  Created by hoang on 31/10/2022.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let roundedRect = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            
            if isFaceUp {
                roundedRect.foregroundColor(.white)
                roundedRect.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                roundedRect.fill()
            }
            content
                .opacity(isFaceUp ? 1 : 0)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let lineWidth: CGFloat = 3
    }
    
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
