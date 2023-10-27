//
//  DiskManager.swift
//  MovieDataBaseApp
//
//  Created by Shubhransh Gupta on 27/10/23.
//

import Foundation

class DiskManager {
    
    func loadMoviesFromJSONFile(filename: String) -> [Movie]? {
        
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                let movies = try decoder.decode([Movie].self, from: data)
                return movies
            } catch {
                print("Error reading or parsing JSON file: \(error)")
            }
        }
        return nil
    }
    
    
    
}
