//
//  VideoServiceMock.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 19.06.2023.
//

import Foundation

protocol VideoServiceProtocol: AnyObject {
    func obtainVideos(completion: @escaping (Result<[Video], Error>) -> Void)
}

final class VideoServiceMock: VideoServiceProtocol {
    func obtainVideos(completion: @escaping (Result<[Video], Error>) -> Void) {
        if let url = Bundle.main.url(forResource: "movie", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Movie].self, from: data)
                completion(.success(toVideos(movies: jsonData)))
            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(NSError(domain: "", code: 1000)))
        }
    }
}

// MARK: - Private Methods

private extension VideoServiceMock {
    func toVideos(movies: [Movie]) -> [Video] {
        movies.map {
            let videoUrl = $0.linkYoutubeShorts ?? ""
            let videoId = videoUrl
                .replacingOccurrences(of: "https://youtube.com/shorts/", with: "")
                .replacingOccurrences(of: "?feature=share", with: "")
            
            return Video(
                videoId: videoId,
                movieName: $0.name ?? "",
                rate: $0.rate ?? "",
                country: $0.countryProduction ?? "",
                year: $0.year ?? "",
                movieDescription: $0.description ?? "",
                genres: ($0.genre ?? "").components(separatedBy: ", ").map { $0.capitalized },
                movieUrl: URL(string: $0.linkKinopoisk ?? "")
            )
        }.shuffled()
    }
}
