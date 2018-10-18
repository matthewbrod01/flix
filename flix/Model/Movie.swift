//
//  Movie.swift
//  flix
//
//  Created by Matthew on 10/17/18.
//  Copyright © 2018 Matthew. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var overview: String
    var releaseDate: String
    var voteAverage: Double
    var baseUrl: String = "https://image.tmdb.org/t/p/w500"
    var backdropPath: String
    var posterPath: String
    var posterUrl: URL?
    var backdropUrl: URL?
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"
        releaseDate = dictionary["release_date"] as? String ?? "No release date"
        voteAverage = dictionary["vote_average"] as? Double ?? 0.00
        backdropPath = dictionary["backdrop_path"] as? String ?? "No backdrop path"
        posterPath = dictionary["poster_path"] as? String ?? "No backdrop path"
        posterUrl = URL(string: baseUrl + posterPath)!
        backdropUrl = URL(string: baseUrl + backdropPath)!
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }

}
