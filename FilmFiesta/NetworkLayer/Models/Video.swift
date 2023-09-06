//
//  Video.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 04.06.2023.
//

import Foundation
import RealmSwift

class Video: Object, Codable {
    @objc dynamic var videoId: String = ""
    @objc dynamic var movieName: String = ""
    @objc dynamic var rate: String = ""
    @objc dynamic var country: String = ""
    @objc dynamic var year: String = ""
    @objc dynamic var movieDescription: String = ""
    dynamic var genres: [String] = []
    var moviewUrl: URL? = nil
    
    convenience init(
        videoId: String,
        movieName: String,
        rate: String,
        country: String,
        year: String,
        movieDescription: String,
        genres: [String],
        movieUrl: URL?
    ) {
        self.init()
        self.videoId = videoId
        self.movieName = movieName
        self.rate = rate
        self.country = country
        self.year = year
        self.movieDescription = movieDescription
        self.genres = genres
        self.moviewUrl = movieUrl
    }
    
    override static func primaryKey() -> String? {
        return "videoId"
    }
}
