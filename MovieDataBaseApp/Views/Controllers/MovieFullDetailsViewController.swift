//
//  MovieFullDetailsViewController.swift
//  MovieDataBaseApp
//
//  Created by Shubhransh Gupta on 28/10/23.
//

import UIKit

class MovieFullDetailsViewController: UIViewController {
    
    // Create UI elements
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // Set image for the poster
        // imageView.image = UIImage(named: "movie_poster_image")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        // Set movie title
        // label.text = "Movie Title"
        return label
    }()
    
    let plotTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        // Set movie plot
        // textView.text = "Movie plot goes here..."
        return textView
    }()
    
    let castCrewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        // Set cast and crew details
        // label.text = "Cast & Crew: Actor 1, Actor 2, Director 1"
        return label
    }()
    
    let releasedDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        // Set released date
        // label.text = "Released Date: Jan 1, 2023"
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        // Set movie genre
        // label.text = "Genre: Action, Adventure"
        return label
    }()
    
    let ratingControl: RatingControlView = {
        let control = RatingControlView()
        control.translatesAutoresizingMaskIntoConstraints = false
        // Set initial rating value
        // control.ratingValue = 4.5
        return control
    }()
    
    let ratingSourceSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["IMDB", "Rotten Tomatoes", "Metacritic"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        // Set segment control target action to handle changes
        segmentedControl.addTarget(self, action: #selector(ratingSourceChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    var movie: Movie?
    var currImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Add UI elements to the view
        view.addSubview(posterImageView)
        view.addSubview(titleLabel)
        view.addSubview(plotTextView)
        view.addSubview(castCrewLabel)
        view.addSubview(releasedDateLabel)
        view.addSubview(genreLabel)
        view.addSubview(ratingControl)
        view.addSubview(ratingSourceSegmentedControl)
        view.addSubview(ratingLabel)

        // Set up constraints
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            posterImageView.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            plotTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            plotTextView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            plotTextView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            plotTextView.heightAnchor.constraint(equalToConstant: 200),
            
            castCrewLabel.topAnchor.constraint(equalTo: plotTextView.bottomAnchor, constant: 10),
            castCrewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            castCrewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            releasedDateLabel.topAnchor.constraint(equalTo: castCrewLabel.bottomAnchor, constant: 10),
            releasedDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            genreLabel.topAnchor.constraint(equalTo: releasedDateLabel.bottomAnchor, constant: 10),
            genreLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            ratingControl.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 20),
            ratingControl.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            ratingSourceSegmentedControl.topAnchor.constraint(equalTo: ratingControl.bottomAnchor, constant: 30),
            ratingSourceSegmentedControl.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingSourceSegmentedControl.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            ratingLabel.topAnchor.constraint(equalTo: ratingSourceSegmentedControl.bottomAnchor, constant: 10),
            ratingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ])
        
        // Populate UI with movie details
        if let movie = movie {
            posterImageView.image = currImage
            titleLabel.text = movie.title
            plotTextView.text = movie.plot
            castCrewLabel.text = "Cast & Crew: \(movie.actors)"
            releasedDateLabel.text = "Released Date: \(movie.released)"
            genreLabel.text = "Genre: \(movie.genre)"
            ratingLabel.text = "IMDB Ratings : " + "\(movie.imdbRating)"
        }
    }
    
    @objc func ratingSourceChanged() {
        // Handle the selected rating source (IMDB, Rotten Tomatoes, Metacritic)
        switch ratingSourceSegmentedControl.selectedSegmentIndex {
        case 0:
            ratingControl.ratingValue = Double(movie?.imdbRating ?? "0") ?? 4.0
            ratingLabel.text = "IMDB Ratings : " + "\(movie?.imdbRating ?? "")"
        case 1:
            if movie?.ratings.count ?? 0 > 1 {
                ratingControl.ratingValue = Double(movie?.ratings[1].value ?? "0") ?? 4.0
                ratingLabel.text = "Rotten Tomatoes Ratings : " + "\(movie?.ratings[1].value ?? "")"
            }
        case 2:
            if movie?.ratings.count ?? 0 > 2 {
                ratingControl.ratingValue = Double(movie?.ratings.last?.value ?? "0") ?? 4.0
                ratingLabel.text = "Metacritic Ratings : " + "\(movie?.ratings.last?.value ?? "")"
            }
        default:
            break
        }
    }
}
