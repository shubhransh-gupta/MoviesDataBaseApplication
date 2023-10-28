//
//  CategoriesDetailsViewController.swift
//  MovieDataBaseApp
//
//  Created by Shubhransh Gupta on 28/10/23.
//

import UIKit

class CategoriesDetailsViewController : UIViewController {
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // Create a UILabel
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var categoryMovies : [String] = []
    var titleC : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background color of the view
        view.backgroundColor = .white
        
        // Add the UITextView to the view
        view.addSubview(textView)
        
        // Add the UILabel to the view
        view.addSubview(label)
        
        // Set up constraints for the UITextView
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 150) // Adjust the height as needed
        ])
        
        // Set up constraints for the UILabel
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        label.text = titleC
        
        for val in categoryMovies {
            textView.text = "\(val)\n"
        }
    }
}
