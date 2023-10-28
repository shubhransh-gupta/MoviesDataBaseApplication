//
//  HomeViewController+TableViewDelegates.swift
//  MovieDataBaseApp
//
//  Created by Shubhransh Gupta on 28/10/23.
//

import UIKit

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 2:
            return self.homeViewModel.searchedMovies.count
        default:
            return getNoOfRowsAtForDefaultView(section: section)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 1 {
            switch indexPath.section {
            case 4:
                return 120
            default:
                return 60
            }
        }
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.tableView.tag == 2 {
            return getSearchedCategoriesCell(tableView, cellForRowAt: indexPath)
        } else {
            switch indexPath.section {
            case 4:
                return getMovieDetailsCell(tableView, cellForRowAt: indexPath)
            default:
                return getRespectiveCategoriesCell(tableView, cellForRowAt: indexPath)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.tableView.tag == 2 {
            return 1
        } else {
            return self.homeViewModel.isSectionExpanded.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView.tag == 1 {
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
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView.tag == 1 {
            return 40
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 1 {
            switch indexPath.section {
            case 4:
                let vc = MovieFullDetailsViewController()
                vc.movie = self.homeViewModel.allMovies[indexPath.row]
                vc.currImage = self.homeViewModel.allMovies[indexPath.row].actualImage
                present(vc, animated: true)
            default:
                let vc = CategoriesDetailsViewController()
                let keyValue = self.homeViewModel.currentCategory[indexPath.section][indexPath.row]
                vc.categoryMovies = self.homeViewModel.sections[indexPath.section].categories[keyValue] ?? []
                vc.titleC = keyValue
                present(vc, animated: true)
            }
        } else {
            let vc = MovieFullDetailsViewController()
            vc.movie = self.homeViewModel.searchedMovies[indexPath.row]
            vc.currImage = self.homeViewModel.searchedMovies[indexPath.row].actualImage
            present(vc, animated: true)
        }
    }
}

extension HomeViewController {
    fileprivate func getNoOfRowsAtForDefaultView(section : Int) -> Int {
        switch section {
        case 4:
            return self.homeViewModel.isSectionExpanded[section] ? self.homeViewModel.allMovies.count : 0
        default:
            return self.homeViewModel.isSectionExpanded[section] ? self.homeViewModel.sections[section].categories.keys.count : 0
        }
    }
}
