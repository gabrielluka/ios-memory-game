//
//  Array+Identifiable.swift
//  MemoryGame
//
//  Created by Gabriel Lucas Santos on 04/04/21.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
