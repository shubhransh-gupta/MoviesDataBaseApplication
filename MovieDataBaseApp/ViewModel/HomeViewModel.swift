//
//  HomeViewModel.swift
//  MovieDataBaseApp
//
//  Created by Shubhransh Gupta on 27/10/23.
//

import UIKit

class HomeViewModel {
    
    let diskManager : DiskManager?
    let networkManager : NetworkManager?
    
    var allMovies : [Movie] = []
    var searchedMovies : [Movie] = []
    var sections: [Section] = Array(repeating: Section(), count: 5)
    var isSectionExpanded: [Bool] = [false, false, false, false, false]
    var imageCache : [UIImage] = []
    
    init(diskManager: DiskManager?, networkManager : NetworkManager?) {
        self.diskManager = diskManager
        self.networkManager = networkManager
    }
    
    public func willLoadDataFromJsonFile(fileName : String) {
        if let movies = self.diskManager?.loadMoviesFromJSONFile(filename: fileName) {
            self.allMovies = movies
            self.populateDataInYearCategory()
            self.populateDataInGenreCategory()
            self.populateDataInDirectorCategory()
            self.populateDataInActorCategory()
        } else {
            print("Failed to load movies from JSON file.")
        }
    }

    
    
}

extension HomeViewModel {
    
    private func populateDataInYearCategory() {
        for movie in self.allMovies {
            let year = movie.year
            if self.sections[0].categories[year] == nil {
                self.sections[0].categories[year] = [movie]
            } else {
                self.sections[0].categories[year]?.append(movie)
            }
        }
    }
    
    private func populateDataInGenreCategory() {
        for movie in self.allMovies {
            let genre = movie.genre.components(separatedBy: ",")
            for gen in genre {
                if self.sections[1].categories[gen] == nil {
                    self.sections[1].categories[gen] = [movie]
                } else {
                    self.sections[1].categories[gen]?.append(movie)
                }
            }
        }
    }
    
    private func populateDataInActorCategory() {
        for movie in self.allMovies {
            let actors = movie.actors.components(separatedBy: ",")
            for act in actors {
                if self.sections[3].categories[act] == nil {
                    self.sections[3].categories[act] = [movie]
                } else {
                    self.sections[3].categories[act]?.append(movie)
                }
            }
        }
    }
    
    private func populateDataInDirectorCategory() {
        for movie in self.allMovies {
            let director = movie.director.components(separatedBy: ",")
            for dir in director {
                if self.sections[2].categories[dir] == nil {
                    self.sections[2].categories[dir] = [movie]
                } else {
                    self.sections[2].categories[dir]?.append(movie)
                }
            }
        }
    }
    
}

extension HomeViewModel {
    public func searchMovies(query: String) -> [Movie] {
        let lowercasedQuery = query.lowercased()
        
        return allMovies.filter { movie in
            return
                movie.title.lowercased().contains(lowercasedQuery) ||
                movie.genre.lowercased().contains(lowercasedQuery) ||
                movie.actors.lowercased().contains(lowercasedQuery) ||
                movie.director.lowercased().contains(lowercasedQuery)
        }
    }
    
    public func fetchImage(imageUrlString : String, OnSuccess : @escaping (UIImage) -> ()) {
        self.networkManager?.getImage(imageUrlString: imageUrlString, OnSuccess: { image in
            OnSuccess(image)
        })
    }
}
