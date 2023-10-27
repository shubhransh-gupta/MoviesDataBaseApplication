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
        self.registerTableViewCells()
        updateUI()
        // Do any additional setup after loading the view.
    }

    func registerTableViewCells() {
        tableView.register(UINib(nibName: "MovieDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieDetailsTableViewCell")
        tableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoriesTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func updateUI() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 4:
            return self.homeViewModel.allMovies.count
        default:
            return self.homeViewModel.isSectionExpanded[section] ? self.homeViewModel.sections[section].categories.keys.count : 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 4:
            return 120
        default:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 4:
            return getMovieDetailsCell(tableView, cellForRowAt: indexPath)
        default:
            return getRespectiveCategoriesCell(tableView, cellForRowAt: indexPath)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            print("Year")
            return getSectionHeader(text: "Year", section: section)
        case 1:
            print("Genre")
            return getSectionHeader(text: "Genre",section: section)
        case 2:
            print("Directors")
            return getSectionHeader(text: "Directors", section: section)
        case 3:
            print("Actors")
            return getSectionHeader(text: "Actors", section: section)
        case 4:
            print("All Movies")
            return getSectionHeader(text: "All Movies",section: section)
        default:
            return UIView()
        }
                          
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 4:
            let vc = MovieFullDetailsViewController()
            vc.movie = self.homeViewModel.allMovies[indexPath.row]
            vc.currImage = self.homeViewModel.imageCache[indexPath.row]
            present(vc, animated: true)
        default:
            print("touched")
        }
    }
    
    
}

extension HomeViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        self.homeViewModel.searchedMovies = self.homeViewModel.searchMovies(query: searchText)
    }
    
}

extension HomeViewController {
    
    private func getMovieDetailsCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> MovieDetailsTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsTableViewCell") as! MovieDetailsTableViewCell
        cell.title.text = self.homeViewModel.allMovies[indexPath.row].title
        cell.language.text = "Language :  " + "\(self.homeViewModel.allMovies[indexPath.row].language)"
        cell.year.text = "Year :  " + "\(self.homeViewModel.allMovies[indexPath.row].year)"
        self.homeViewModel.fetchImage(imageUrlString: self.homeViewModel.allMovies[indexPath.row].poster, OnSuccess: { image in
            cell.poster.image = image
            self.homeViewModel.imageCache.append(image)
        })
        return cell
    }
    
    private func getRespectiveCategoriesCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CategoriesTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell") as! CategoriesTableViewCell
        cell.showButton(visibility: false)
        let categories = self.homeViewModel.sections[indexPath.section].categories
        for (index, categ) in categories.enumerated() {
            if index == indexPath.row {
                cell.label.text = categ.key
            }
        }
        
        return cell
    }
    
    private func getSectionHeader(text : String, section : Int) -> UIView {
        let view = Bundle.main.loadNibNamed("CategoriesTableViewCell", owner: self)?.first as! CategoriesTableViewCell
        view.label.text = text
        view.showButton(visibility: true)
        view.backgroundColor = UIColor.lightGray // Set the background color
        view.layer.borderWidth = 1.0 // Add a 1-point border
        view.layer.borderColor = UIColor.black.cgColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sectionHeaderTapped(_:)))
        view.addGestureRecognizer(tapGesture)
        view.tag = section
        return view
    }
    
    @objc func sectionHeaderTapped(_ sender: UITapGestureRecognizer) {
        if let section = sender.view?.tag {
            // Handle the tap on the section header with 'section' index
            self.homeViewModel.isSectionExpanded = [false, false, false, false, false]
            self.homeViewModel.isSectionExpanded[section] = !self.homeViewModel.isSectionExpanded[section]
            self.tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        }
    }
    
}
