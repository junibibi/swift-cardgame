//
//  Hands.swift
//  CardGame
//
//  Created by Daheen Lee on 03/07/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum Hands: Int, Comparable {
    case highCard = 0
    case onePair
    case twoPair
    case threeOfKind
    case straight
    case fourOfKind
    
    static func < (lhs: Hands, rhs: Hands) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}