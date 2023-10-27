//
//  HomeViewModel.swift
//  MovieDataBaseApp
//
//  Created by Shubhransh Gupta on 27/10/23.
//

import Foundation

class HomeViewModel {
    
    let diskManager : DiskManager?
    let networkManager : NetworkManager?
    
    var allMovies : [Movie] = []
    var yearCategories: [String: [Movie]] = [:]
    var genreCategories: [String: [Movie]] = [:]
    var directorCategories: [String: [Movie]] = [:]
    var actorsCategories: [String: [Movie]] = [:]
    
    init(diskManager: DiskManager?, networkManager : NetworkManager?) {
        self.diskManager = diskManager
        self.networkManager = networkManager
    }
    
    func willLoadDataFromJsonFile(fileName : String) {
        if let movies = self.diskManager?.loadMoviesFromJSONFile(filename: fileName) {
            self.allMovies = movies
            self.populateDataInYearCategory()
            self.populateDataInActorCategory()
            self.populateDataInGenreCategory()
            self.populateDataInDirectorCategory()
        } else {
            print("Failed to load movies from JSON file.")
        }
    }
    

    
    
}

extension HomeViewModel {
    
    func populateDataInYearCategory() {
        for movie in self.allMovies {
            let year = movie.year
            if yearCategories[year] == nil {
                yearCategories[year] = [movie]
            } else {
                yearCategories[year]?.append(movie)
            }
        }
    }
    
    func populateDataInGenreCategory() {
        for movie in self.allMovies {
            let genre = movie.genre
            if genreCategories[genre] == nil {
                genreCategories[genre] = [movie]
            } else {
                genreCategories[genre]?.append(movie)
            }
        }
    }
    
    func populateDataInActorCategory() {
        for movie in self.allMovies {
            let actors = movie.actors
            if actorsCategories[actors] == nil {
                actorsCategories[actors] = [movie]
            } else {
                actorsCategories[actors]?.append(movie)
            }
        }
    }
    
    func populateDataInDirectorCategory() {
        for movie in self.allMovies {
            let director = movie.director
            if directorCategories[director] == nil {
                directorCategories[director] = [movie]
            } else {
                directorCategories[director]?.append(movie)
            }
        }
    }
}
