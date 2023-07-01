//
//  CarouselViewModel.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 29.05.2023.
//

import UIKit
import RealmSwift

protocol CarouselViewModelProtocol: AnyObject {
    func viewLoaded()
}

final class CarouselViewModel {
    weak var view: CarouselViewProtocol?
    
    private let router: CarouselRouterProtocol
    private let videoService: VideoServiceProtocol
    private let deeplinkVideoId: String?
    
    private var videos: [Video] = []
    private var currentIndex = 0
    
    init(
        router: CarouselRouterProtocol,
        videoService: VideoServiceProtocol,
        deeplinkVideoId: String?
    ) {
        self.router = router
        self.videoService = videoService
        self.deeplinkVideoId = deeplinkVideoId
    }
}

// MARK: - CarouselViewModelProtocol

extension CarouselViewModel: CarouselViewModelProtocol {
    func viewLoaded() {
        loadVideos()
    }
}

// MARK: - Private Methods

private extension CarouselViewModel {
    func loadVideos() {
        videoService.obtainVideos { [weak self] result in
            switch result {
            case let .success(videos):
                self?.videos = videos
                self?.showFirstVideo()
            case .failure:
                break
            }
        }
    }
    
    func getPlayerVars(video: Video) -> [String: Any] {
        [
            "loop": 1,
            "playlist": video.videoId,
            "modestbranding" : 1,
            "controls" : 0,
            "autoplay" : 1,
            "playsinline" : 1,
            "showinfo" : 0,
            "iv_load_policy": 0,
            "rel": 0,
            "showsearch": 0
        ]
    }
    
    func showFirstVideo() {
        if let deeplinkVideoId = deeplinkVideoId,
           let deeplinkVideo = videos.first(where: { $0.videoId == deeplinkVideoId }) {
            currentIndex = videos.firstIndex(of: deeplinkVideo) ?? 0
            updateView(with: deeplinkVideo)
            return
        }
        
        if let video = videos.first {
            updateView(with: video)
        }
    }
    
    func showNextVideo() {
        currentIndex += 1
        
        if let video = videos[safe: currentIndex] {
            updateView(with: video)
        }
    }
    
    func showPreviousVideo() {
        currentIndex -= 1
        
        if let video = videos[safe: currentIndex] {
            updateView(with: video)
        }
    }
    
    func addToFavourites(video: Video) {
        guard let realm = try? Realm() else { return }

        do {
            try realm.write {
                if let savedVideo = realm.object(ofType: Video.self, forPrimaryKey: video.videoId),
                    !savedVideo.isInvalidated {
                    realm.delete(savedVideo)
                } else {
                    realm.create(Video.self, value: video)
                }
            }
        } catch {
            print("error - \(error.localizedDescription)")
        }
    }
    
    func checkRealmVideoState(video: Video) -> Bool {
        guard let realm = try? Realm() else { return false }

        guard let savedVideo = realm.object(ofType: Video.self, forPrimaryKey: video.videoId),
              !savedVideo.isInvalidated
        else { return false }
        
        return true
    }
    
    func share(video: Video) {
        guard let deeplink = getDeeplinkUrl(video: video) else { return }
        
        let description = video.movieName + "\n" + video.country + " " + video.year
        
        let activityItems: [Any] = [
            description,
            deeplink
        ]
        
        router.showShareController(activityItems: activityItems)
    }
    
    func getDeeplinkUrl(video: Video) -> URL? {
        guard let deeplink = URL(string: "https://filmfiesta.page.link/video"),
              var components = URLComponents(url: deeplink, resolvingAgainstBaseURL: true)
        else { return nil }

        components.queryItems = [URLQueryItem(name: "videoId", value: video.videoId)]
        
        return components.url
    }
    
    func showInOnlineCinema(video: Video) {
        guard let moviewUrl = video.moviewUrl else { return }
        UIApplication.shared.open(moviewUrl)
    }
    
    func updateView(with video: Video) {
        view?.update(with: .init(
            video: video,
            isFirstVideo: currentIndex == 0,
            isLastVideo: currentIndex + 1 == videos.count,
            favouriteButtonState: checkRealmVideoState(video: video),
            playerVars: getPlayerVars(video: video),
            onShowNextVideo: { [weak self] in self?.showNextVideo() },
            onShowPreviousVideo: { [weak self] in self?.showPreviousVideo() },
            onFavouriteAction: { [weak self] in self?.addToFavourites(video: video) },
            onShareAction: { [weak self] in self?.share(video: video) },
            onOnlineCinemaAction: { [weak self] in self?.showInOnlineCinema(video: video) }
        ))
    }
}
