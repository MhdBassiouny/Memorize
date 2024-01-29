//
//  Cardify.swift
//  Memorize
//
//  Created by Muhammad Bassiouny on 9/13/23.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var rotation: Double
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue}
    }
    
    func body(content: Content) -> some View  {
        let base = RoundedRectangle(cornerRadius: 12)
        ZStack {
            base.strokeBorder(lineWidth: 3)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0,1,0))
    }
}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
