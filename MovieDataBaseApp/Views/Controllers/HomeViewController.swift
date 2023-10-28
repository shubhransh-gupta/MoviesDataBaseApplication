//
//  ViewController.swift
//  MovieDataBaseApp
//
//  Created by Shubhransh Gupta on 27/10/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let homeViewModel : HomeViewModel = HomeViewModel(diskManager: DiskManager(), networkManager: NetworkManager())
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.willLoadDataFromJsonFile(fileName: "movies")
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerTableViewCells()
    }

    func registerTableViewCells() {
        if self.tableView.tag == 1 {
            tableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoriesTableViewCell")
        }
        tableView.register(UINib(nibName: "MovieDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieDetailsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func updateUI() {
        self.title = "Movie Database"
        self.tableView.tag = 1
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search movies by title/actors/genre/directors"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

}

extension HomeViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            self.tableView.tag = 2
            self.homeViewModel.searchedMovies = self.homeViewModel.searchMovies(query: searchText)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else {
            self.tableView.tag = 1
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension HomeViewController {
    
    public func getMovieDetailsCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> MovieDetailsTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsTableViewCell") as! MovieDetailsTableViewCell
        cell.title.text = self.homeViewModel.allMovies[indexPath.row].title
        cell.language.text = "Language :  " + "\(self.homeViewModel.allMovies[indexPath.row].language)"
        cell.year.text = "Year :  " + "\(self.homeViewModel.allMovies[indexPath.row].year)"
        self.homeViewModel.fetchImage(imageUrlString: self.homeViewModel.allMovies[indexPath.row].poster, OnSuccess: { image in
            cell.poster.image = image
            self.homeViewModel.allMovies[indexPath.row].actualImage = image
        })
        return cell
    }
    
    public func getRespectiveCategoriesCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CategoriesTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell") as! CategoriesTableViewCell
        cell.showButton(visibility: false)
        let categories = self.homeViewModel.sections[indexPath.section].categories
        for (index, categ) in categories.enumerated() {
            if index == indexPath.row {
                cell.label.text = categ.key
                self.homeViewModel.currentCategory[indexPath.section].append(categ.key)
            }
        }
        
        return cell
    }
    
    public func getSectionHeader(text : String, section : Int) -> UIView {
        let view = Bundle.main.loadNibNamed("CategoriesTableViewCell", owner: self)?.first as! CategoriesTableViewCell
        view.label.text = text
        view.showButton(visibility: true)
        view.backgroundColor = UIColor.systemGray6 // Set the background color
        view.layer.borderWidth = 1.0 // Add a 1-point border
        view.layer.borderColor = UIColor.black.cgColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sectionHeaderTapped(_:)))
        view.addGestureRecognizer(tapGesture)
        view.tag = section
        return view
    }
    
    public func getSearchedCategoriesCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> MovieDetailsTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsTableViewCell") as! MovieDetailsTableViewCell
        cell.title.text = self.homeViewModel.searchedMovies[indexPath.row].title
        cell.language.text = "Language :  " + "\(self.homeViewModel.searchedMovies[indexPath.row].language)"
        cell.year.text = "Year :  " + "\(self.homeViewModel.searchedMovies[indexPath.row].year)"
        self.homeViewModel.fetchImage(imageUrlString: self.homeViewModel.searchedMovies[indexPath.row].poster, OnSuccess: { image in
            cell.poster.image = image
            self.homeViewModel.searchedMovies[indexPath.row].actualImage = image
        })
        return cell
    }
    
    @objc func sectionHeaderTapped(_ sender: UITapGestureRecognizer) {
        if let section = sender.view?.tag {
            // Handle the tap on the section header with 'section' index
            self.homeViewModel.isSectionExpanded[section] = !self.homeViewModel.isSectionExpanded[section]
            DispatchQueue.main.async {
                self.tableView.beginUpdates()
                self.tableView.reloadSections(IndexSet(integer: section), with: .automatic)
                self.tableView.reloadData()
                self.tableView.layoutIfNeeded()
                self.tableView.endUpdates()
            }
        }
    }
    
}
