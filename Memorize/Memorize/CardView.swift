//
//  CardView.swift
//  Memorize
//
//  Created by Muhammad Bassiouny on 9/11/23.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                .opacity(0.4)
                .overlay(cardContents)
                .cardify(isFaceUp: card.isFaceUp)
                .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        }
    }
    
    var cardContents: some View {
        Text(card.content)
            .font(.system(size: 200))
            .minimumScaleFactor(0.01)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode: .fit)
            .padding(5)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 1), value: card.isMatched)
    }
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: duration).repeatForever(autoreverses: false)
    }
}

struct CardView_Previews: PreviewProvider {
    typealias Card = MemoryGame<String>.Card
    
    static var previews: some View {
        CardView(card: Card(content: "X", id: "Test"))
    }
}
