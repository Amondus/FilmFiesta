//
//  Collection+safe.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 11.06.2023.
//

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
