//
//  Moview.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 19.06.2023.
//

import Foundation

struct Movie: Codable {
    let rate: String?
    let description: String?
    let linkKinopoisk: String?
    let id: Int?
    let linkYoutubeShorts: String?
    let year: String?
    let linkOkko: String?
    let countryProduction: String?
    let genre: String?
    let name: String?
}
