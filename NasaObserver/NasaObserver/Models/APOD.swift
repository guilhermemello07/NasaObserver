//
//  APOD.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 28/02/2025.
//

import Foundation


struct APOD: Codable {
    let copyright: String?
    let date: String
    let explanation: String
    let hdurl: String?
    let mediaType: String
    let serviceVersion: String
    let title: String
    let url: String
    let thumbnailUrl: String?
    
    var isFavorited: Bool = false
    let id = UUID()
    
    var imageURL: URL? {
        if mediaType == "video" {
            return nil
        }
        return URL(string: hdurl ?? url)
    }
    
    var videoURL: URL? {
        if mediaType == "image" {
            return nil
        }
        return URL(string: url)
    }
    
    
    mutating func toggleFavorite() {
        isFavorited.toggle()
    }
    
    
    
    // MARK: - Decodable
    enum CodingKeys: String, CodingKey {
        // only list the keys that are in the JSON response...
        case copyright
        case date
        case explanation
        case hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title
        case url
        case thumbnailUrl = "thumbnail_url"
    }
    
    
    // MARK: - Sample data
    public static let sampleDataWithImage = APOD(copyright: "Evan Tsai",
                                                 date: "2025-02-27",
                                                 explanation: "Framed in this single, starry, telescopic field of view are two open star clusters, M35 and NGC 2158. Located within the boundaries of the constellation Gemini, they do appear to be side by side. Its stars concentrated toward the upper right, M35 is relatively nearby, though. M35 (also cataloged as NGC 2168) is a mere 2800 light-years distant, with 400 or so stars spread out over a volume about 30 light-years across. Bright blue stars frequently distinguish younger open clusters like M35, whose age is estimated at 150 million years. At lower left, NGC 2158 is about four times more distant than M35 and much more compact, shining with the more yellowish light of a population of stars over 10 times older. In general, open star clusters are found along the plane of our Milky Way Galaxy. Loosely gravitationally bound, their member stars tend to be dispersed over billions of years as the open star clusters orbit the galactic center.",
                                                 hdurl: "https://apod.nasa.gov/apod/image/2502/M35_NGC2158_2048.jpg",
                                                 mediaType: "image",
                                                 serviceVersion: "v1",
                                                 title: "Open Star Clusters M35 and NGC 2158",
                                                 url: "https://apod.nasa.gov/apod/image/2502/M35_NGC2158_1024.jpg",
                                                 thumbnailUrl: nil,
                                                 isFavorited: false)
    
    
    public static let sampleDataWithVideo = APOD(copyright: nil,
                                                 date: "2021-10-11",
                                                 explanation: "What would it be like to fly over the largest moon in the Solar System? In June, the robotic Juno spacecraft flew past Jupiter's huge moon Ganymede and took images that have been digitally constructed into a detailed flyby. As the featured video begins, Juno swoops over the two-toned surface of the 2,000-km wide moon, revealing an icy alien landscape filled with grooves and craters. The grooves are likely caused by shifting surface plates, while the craters are caused by violent impacts. Continuing on in its orbit, Juno then performed its 34th close pass over Jupiter's clouds. The digitally-constructed video shows numerous swirling clouds in the north, colorful planet-circling zones and bands across the middle -- featuring several white-oval clouds from the String of Pearls, and finally more swirling clouds in the south.  Next September, Juno is scheduled to make a close pass over another of Jupiter's large moons: Europa.",
                                                 hdurl: nil,
                                                 mediaType: "video",
                                                 serviceVersion: "v1",
                                                 title: "Juno Flyby of Ganymede and Jupiter",
                                                 url: "https://www.youtube.com/embed/CC7OJ7gFLvE?rel=0",
                                                 thumbnailUrl: "https://img.youtube.com/vi/CC7OJ7gFLvE/0.jpg",
                                                 isFavorited: false)
}
