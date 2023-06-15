//
//  SearchViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 14.06.2023.
//

import UIKit

class SearchViewController: CustomViewController<SearchView> {
    
    let sectionsTitles = ["Top Searching", "Artist", "Album", "Song", "Playlist"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
        
        customView.mainTableView.dataSource = self
        customView.mainTableView.delegate = self
        
        customView.searchItemsCollectionView.dataSource = self
        customView.searchItemsCollectionView.delegate = self
    }
    
    @objc func addTapped() {
        
    }
}

//MARK: - SearchViewDelegate
extension SearchViewController: SearchViewDelegate {
    func searchView(_ view: SearchView, didTapCloseButton button: UIButton) {
        //Close SearchViewController
        print("Close button tapped")
    }
}

//MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
    }
    
    
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsTitles.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.frame.width - 30, height: 20))
        label.text = sectionsTitles[section]
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor.white
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else {
            fatalError("Error")
        }
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Play song, open album etc
    }
    
}

//MARK: - SearchCellDelegate
extension SearchViewController: SearchCellDelegate {
    func moreActionsButtonTapped(_ cell: SearchCell) {
        print("More actions")
    }
    
    
}
