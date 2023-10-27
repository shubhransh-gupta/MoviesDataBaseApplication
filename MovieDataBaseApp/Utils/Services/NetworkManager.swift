//
//  NetworkManager.swift
//  MovieDataBaseApp
//
//  Created by Shubhransh Gupta on 27/10/23.
//

import UIKit

class NetworkManager {
    
    public func getImage(imageUrlString : String, OnSuccess : @escaping (UIImage) -> ()) {
        if let imageUrl = URL(string: imageUrlString) {
            // Create a URLSession
            let session = URLSession.shared

            // Create a data task to fetch the image data
            let dataTask = session.dataTask(with: imageUrl) { (data, response, error) in
                if error == nil, let imageData = data {
                    // Create an image from the data
                    if let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            OnSuccess(image)
                        }
                    }
                } else {
                    // Handle the error
                    print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                }
            }

            // Start the data task to fetch the image
            dataTask.resume()
        } else {
            print("Invalid URL")
        }
    }
}
