//
//  CardGame.swift
//  CardGame
//
//  Created by 윤지영 on 16/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

class CardGame {
    private let gameMode: GameMode
    private let numberOfPlayers: Int
    private var dealer: Dealer
    private var players: [GamePlayer] = []

    init(gameMode: GameMode, numberOfPlayers: Int) throws {
        self.gameMode = gameMode
        guard numberOfPlayers > 0 else { throw GameInputError.noPlayer }
        self.numberOfPlayers = numberOfPlayers
        self.dealer = Dealer(with: CardDeck())
        setPlayers()
    }

    private func setPlayers() {
        for _ in 1...numberOfPlayers {
            let player = Player()
            players.append(player)
        }
        players.append(dealer)
    }

    private func reset() {
        for player in players {
            player.resetCards()
        }
    }

    private func deal(visually cards: (String, String) -> Void, screen clear: () -> ()) -> Bool {
        for _ in 1...gameMode.numberOfCards {
            for player in players {
                guard let card = dealer.dealOut() else { return false }
                player.take(card: card)
                showResult(of: cards, screen: clear)
            }
        }
        return true
    }

    func play(visually cards: (String, String) -> Void, screen clear: () -> ()) -> Bool {
        reset()
        guard deal(visually: cards, screen: clear) else { return false }
        return true
    }

    func showResult(of result: (String, String) -> Void, screen clear: () -> ()) {
        clear()
        for index in players.indices {
            let name = players[index].getName(with: index+1)
            let cards = players[index].showCards()
            result(name, cards)
        }
        sleep(1)
    }

}
