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
        let videos: [Video] = [
            .init(
                videoId: "82TH6JkBXHc",
                movieName: "Пока не сыграл в ящик",
                rate: "8.0",
                country: "США",
                year: "2007",
                movieDescription: "Именно так решили два больных раком соседа по больничной палате, когда услышали свой приговор. Один из них вспыльчивый миллиардер, а второй эрудированный автомеханик. Они составляют список дел, которые необходимо сделать прежде, чем они сыграют в ящик, и отправляются в кругосветное путешествие, путешествие всей своей жизни. Прыжки с парашютом? Посмотрим. Гонки на раритетных автомобилях? Сделано. Посмотреть на пирамиды? Отлично. Открыть радость жизни прежде, чем станет слишком поздно? Точно!",
                genres: ["🎭 Драма", "😂 Комедия", "🧭 Приключения"],
                movieUrl: URL(string: "https://www.kinopoisk.ru/film/258885/")
            ),
            .init(
                videoId: "aGzN4gMjUyE",
                movieName: "Баллада Бастера Скраггса",
                rate: "7.3",
                country: "США",
                year: "2018",
                movieDescription: "События разворачиваются на Диком Западе в маленьких захолустных городках среди бескрайних американских прерий и высокогорных равнин. В этом суровом мире, где каждый сам за себя, царит один закон: выживает сильнейший.",
                genres: ["🐴 Вестерн", "🎭 Драма", "😂 Комедия", "🏛️ Мюзикл"],
                movieUrl: URL(string: "https://www.kinopoisk.ru/film/1008879/")
            ),
            .init(
                videoId: "9yNNAKdvCmw",
                movieName: "1+1",
                rate: "8.8",
                country: "Франция",
                year: "2011",
                movieDescription: "Пострадав в результате несчастного случая, богатый аристократ Филипп нанимает в помощники человека, который менее всего подходит для этой работы, – молодого жителя предместья Дрисса, только что освободившегося из тюрьмы. Несмотря на то, что Филипп прикован к инвалидному креслу, Дриссу удается привнести в размеренную жизнь аристократа дух приключений.",
                genres: ["🎭 Драма", "😂 Комедия", "🪶 Биография"],
                movieUrl: URL(string: "https://www.kinopoisk.ru/film/535341/")
            ),
            .init(
                videoId: "A1p8XV-fzWE",
                movieName: "Ведьмак (сериал)",
                rate: "7.3",
                country: "США, Польша",
                year: "2014-...",
                movieDescription: "Ведьмак Геральт, мутант и убийца чудовищ, на своей верной лошади по кличке Плотва путешествует по Континенту. За тугой мешочек чеканных монет этот мужчина избавит вас от всякой настырной нечисти — хоть от чудищ болотных, оборотней и даже заколдованных принцесс. В сельской глуши местную девушку Йеннифэр, которой сильно не повезло с внешностью, зато посчастливилось иметь способности к магии, отец продаёт колдунье в ученицы. А малолетняя наследница королевства Цинтра по имени Цири вынуждена пуститься в бега, когда их страну захватывает империя Нильфгаард. Судьбы этих троих окажутся тесно связаны, но скоро сказка сказывается, да не скоро дело делается.",
                genres: ["🧝‍♀️ Фэнтези", "🧭 Приключения", "🎭 Драма", "🙈 Ужасы"],
                movieUrl: URL(string: "https://www.kinopoisk.ru/series/1044004/")
            ),
            .init(
                videoId: "5BL_5xrE_F8",
                movieName: "Впритык",
                rate: "7.2",
                country: "США",
                year: "2010",
                movieDescription: "Питер готовится стать отцом и находится на грани нервного срыва. И его нервам не идет на пользу тот факт, что ему предстоит предпринять целое путешествие, да еще и в компании честолюбивого актера, чтобы успеть добраться домой к рождению собственного ребенка.",
                genres: ["😂 Комедия"],
                movieUrl: URL(string: "https://www.kinopoisk.ru/film/464282/")
            )
        ]
        
        completion(.success(videos))
    }
}
