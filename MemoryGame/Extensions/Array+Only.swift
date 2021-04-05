//
//  Array+Only.swift
//  MemoryGame
//
//  Created by Gabriel Lucas Santos on 04/04/21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
