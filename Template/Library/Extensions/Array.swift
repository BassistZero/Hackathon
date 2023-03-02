//
//  Array.swift
//  Template
//

import Foundation

public extension Array {

    subscript(safe index: Index) -> Element? {
        if indices.contains(index) {
            return self[index]
        }
        return nil
    }

}
