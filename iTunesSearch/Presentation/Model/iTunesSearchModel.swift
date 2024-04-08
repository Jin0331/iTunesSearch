//
//  iTunesSearchModel.swift
//  iTunesSearch
//
//  Created by JinwooLee on 4/5/24.
//

import Foundation

struct iTunesSearchList: Decodable {
    let results: [iTunesSearch]
}

struct iTunesSearch : Decodable {
    let bundleId : String
    let artworkUrl60, artworkUrl100: String
    let screenshotUrls: [String]
    let minimumOSVersion: String
    let averageUserRating: Double
    let trackCensoredName, sellerName, releaseNotes: String
    let artistID: Int
    let artistName: String
    let genres: [String]
    let description: String
    let trackID: Int
    let trackName: String
    let releaseDate, currentVersionReleaseDate: String
    let averageUserRatingForCurrentVersion: Double
    let trackContentRating, version, wrapperType: String

    enum CodingKeys: String, CodingKey {
        case bundleId, artworkUrl60, artworkUrl100, screenshotUrls
        case minimumOSVersion = "minimumOsVersion"
        case averageUserRating, trackCensoredName, sellerName, releaseNotes
        case artistID = "artistId"
        case artistName, genres, description
        case trackID = "trackId"
        case trackName, releaseDate, currentVersionReleaseDate, averageUserRatingForCurrentVersion, trackContentRating, version, wrapperType
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.bundleId = try container.decode(String.self, forKey: .bundleId)
        self.artworkUrl60 = try container.decode(String.self, forKey: .artworkUrl60)
        self.artworkUrl100 = try container.decode(String.self, forKey: .artworkUrl100)
        self.screenshotUrls = try container.decode([String].self, forKey: .screenshotUrls)
        self.minimumOSVersion = try container.decode(String.self, forKey: .minimumOSVersion)
        self.averageUserRating = try container.decode(Double.self, forKey: .averageUserRating)
        self.trackCensoredName = try container.decode(String.self, forKey: .trackCensoredName)
        self.sellerName = try container.decode(String.self, forKey: .sellerName)
        self.releaseNotes = (try? container.decode(String.self, forKey: .releaseNotes)) ?? ""
        self.artistID = try container.decode(Int.self, forKey: .artistID)
        self.artistName = try container.decode(String.self, forKey: .artistName)
        self.genres = try container.decode([String].self, forKey: .genres)
        self.description = try container.decode(String.self, forKey: .description)
        self.trackID = try container.decode(Int.self, forKey: .trackID)
        self.trackName = try container.decode(String.self, forKey: .trackName)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.currentVersionReleaseDate = try container.decode(String.self, forKey: .currentVersionReleaseDate)
        self.averageUserRatingForCurrentVersion = try container.decode(Double.self, forKey: .averageUserRatingForCurrentVersion)
        self.trackContentRating = try container.decode(String.self, forKey: .trackContentRating)
        self.version = try container.decode(String.self, forKey: .version)
        self.wrapperType = try container.decode(String.self, forKey: .wrapperType)
    }
    
    //TODO: - releaseDate, currentVersionReleaseDate -> StringToDate로 변경 필요
    
}
