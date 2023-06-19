//
//  SearchViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 14.06.2023.
//

import UIKit

class SearchViewController: CustomViewController<SearchView> {
    
    let sectionsTitles = ["Top Searching", "Artist", "Album", "Song", "Playlist"]
    var numberOfSection = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
        
        customView.searchItemsCollectionView.cellDelegate = self
        
        customView.mainTableView.dataSource = self
        customView.mainTableView.delegate = self
        
        navigationController?.navigationBar.isHidden = true
    }
}

//MARK: - SearchViewDelegate
extension SearchViewController: SearchViewDelegate {
    func searchView(_ view: SearchView, didTapCloseButton button: UIButton) {
        //Close SearchViewController
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSection
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

//MARK: - SelectCollectionViewItemProtocol
extension SearchViewController: SelectCollectionViewItemProtocol {
    func selectItem(index: IndexPath) {
        switch index.item {
        case 0:
            numberOfSection = 5
            customView.mainTableView.insertSections(IndexSet(integersIn: 1...4), with: .fade)
        case 1:
            if numberOfSection == 5 {
                numberOfSection = 1
                customView.mainTableView.deleteSections(IndexSet(integersIn: 1...4), with: .fade)
            }
        case 2:
            if numberOfSection == 5 {
                numberOfSection = 1
                customView.mainTableView.deleteSections(IndexSet(integersIn: 1...4), with: .fade)
            }
        case 3:
            if numberOfSection == 5 {
                numberOfSection = 1
                customView.mainTableView.deleteSections(IndexSet(integersIn: 1...4), with: .fade)
            }
        case 4:
            if numberOfSection == 5 {
                numberOfSection = 1
                customView.mainTableView.deleteSections(IndexSet(integersIn: 1...4), with: .fade)
            }
            
        default:
            return
        }
    }
}
