//
//  ViewController.swift
//  MovieDataBaseApp
//
//  Created by Shubhransh Gupta on 27/10/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchBox: UISearchController!
    @IBOutlet weak var tableView: UITableView!
    let homeViewModel : HomeViewModel = HomeViewModel(diskManager: DiskManager(), networkManager: NetworkManager())

    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.willLoadDataFromJsonFile(fileName: "movies")
        self.registerTableViewCells()
        
        // Do any additional setup after loading the view.
    }

    func registerTableViewCells() {
        tableView.register(UINib(nibName: "MovieDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieDetailsTableViewCell")
        tableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoriesTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.homeViewModel.isSectionExpanded[section] ? self.homeViewModel.sections[section].categories.keys.count : 0
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
            return getSectionHeader(text: "Year")
        case 1:
            return getSectionHeader(text: "Genre")
        case 2:
            return getSectionHeader(text: "Directors")
        case 3:
            return getSectionHeader(text: "Actors")
        case 4:
            return getSectionHeader(text: "All Movies")
        default:
            return UIView()
        }
                          
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    private func tableView(_ tableView: UITableView, didSelectHeaderInSection section: Int) {
        self.homeViewModel.isSectionExpanded[section] = !self.homeViewModel.isSectionExpanded[section]
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
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
        })
        return cell
    }
    
    private func getRespectiveCategoriesCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CategoriesTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell") as! CategoriesTableViewCell
        let categories = self.homeViewModel.sections[indexPath.section].categories
        for (index, categ) in categories.enumerated() {
            if index == indexPath.row {
                cell.label.text = categ.key
            }
        }
        
        return cell
    }
    
    private func getSectionHeader(text : String) -> UIView {
        let view = UIView(frame: CGRect(x: 50, y: 100, width: 200, height: 100))
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.text = text
        view.addSubview(label)
        return view
    }
}
