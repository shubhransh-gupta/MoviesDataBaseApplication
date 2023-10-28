//
//  RatingControlView.swift
//  MovieDataBaseApp
//
//  Created by Shubhransh Gupta on 28/10/23.
//

import UIKit

class RatingControlView: UIView {
    // The number of rating stars
    let maxRating: Int = 5
    
    // The current rating value (out of maxRating)
    var ratingValue: Double = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    // The spacing between rating stars
    let spacing: CGFloat = 5.0
    
    // The size of each rating star
    let starSize: CGSize = CGSize(width: 30, height: 30)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRatingControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupRatingControl()
    }
    
    func setupRatingControl() {
        for i in 0..<maxRating {
            let starImageView = UIImageView()
            starImageView.contentMode = .scaleAspectFit
            starImageView.image = i < Int(ratingValue) ? UIImage(named: "filledStar") : UIImage(named: "emptyStar")
            starImageView.frame = CGRect(x: CGFloat(i) * (starSize.width + spacing), y: 0, width: starSize.width, height: starSize.height)
            addSubview(starImageView)
        }
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Update the appearance of rating stars when the rating value changes
        for (i, subview) in subviews.enumerated() {
            if let starImageView = subview as? UIImageView {
                starImageView.image = i < Int(ratingValue) ? UIImage(named: "filledStar") : UIImage(named: "emptyStar")
            }
        }
    }
}

