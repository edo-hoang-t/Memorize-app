//
//  Cardify.swift
//  Memorize
//
//  Created by hoang on 31/10/2022.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
        
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    var rotation: Double // in degrees
    
    func body(content: Content) -> some View {
        ZStack {
            let roundedRect = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            
            if rotation < 90 {
                roundedRect.foregroundColor(.white)
                roundedRect.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                roundedRect.fill()
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
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
