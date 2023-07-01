//
//  Genre.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 21.06.2023.
//

import Foundation
import RealmSwift

class Genre: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var isSelected: Bool = false
    
    convenience init(
        title: String,
        isSelected: Bool = false
    ) {
        self.init()
        self.title = title
        self.isSelected = isSelected
    }
}
