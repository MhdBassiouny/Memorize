//
//  ContentView.swift
//  Memorize
//
//  Created by Muhammad Bassiouny on 8/26/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2/3

    var body: some View {
        VStack {
            cards
                .foregroundColor(viewModel.color)
                .padding(.horizontal)
            HStack {
                score
                Spacer()
                deck.foregroundColor(.orange)
                Spacer()
                shuffle
            }
            .font(.largeTitle)
        }
            .navigationTitle("Memorize!")
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }
    
    
    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(4)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
            }

        }
        .foregroundColor(.orange)
    }
    
    @State private var lastScoreChannge = (0, causedByCardId: "")
    
    private func choose(_ card: Card) {
        withAnimation {
            let scoreBeforeChanging = viewModel.score
            viewModel.choose(card)
            let schoreChannge = viewModel.score - scoreBeforeChanging
            lastScoreChannge = (schoreChannge, causedByCardId: card.id)
        }
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChannge
        return card.id == id ? amount : 0
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    @Namespace private var dealingNamespace
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: 50, height: 80)
        .onTapGesture {
            var delay: TimeInterval = 0
            for card in viewModel.cards {
                withAnimation(.easeInOut(duration: 1).delay(delay)) {
                    _ = dealt.insert(card.id)
                }
                delay += 0.1
            }
        }
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
        }
    }
}
