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
        case artworkUrl60, artworkUrl100, screenshotUrls
        case minimumOSVersion = "minimumOsVersion"
        case averageUserRating, trackCensoredName, sellerName, releaseNotes
        case artistID = "artistId"
        case artistName, genres, description
        case trackID = "trackId"
        case trackName, releaseDate, currentVersionReleaseDate, averageUserRatingForCurrentVersion, trackContentRating, version, wrapperType
    }
    
    //TODO: - releaseDate, currentVersionReleaseDate -> StringToDate로 변경 필요
    
}
