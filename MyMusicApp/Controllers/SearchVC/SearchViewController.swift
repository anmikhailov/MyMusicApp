//
//  SearchViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 14.06.2023.
//

import UIKit

struct SearchSection {
    let title: String
    let results: [SearchResult]
}

enum Sections {
    case artist
    case album
    case track
    case playlist
    case all
}

class SearchViewController: CustomViewController<SearchView> {
    
    var currentSection: Sections = .all
    private var sections: [SearchSection] = []
    private var searchResults: [SearchResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
        
        customView.searchItemsCollectionView.cellDelegate = self
        customView.searchView.delegate = self
        customView.mainTableView.dataSource = self
        customView.mainTableView.delegate = self
        
        navigationController?.navigationBar.isHidden = true
    }
    
    func fetchSearchResults(for section: Sections, with results: [SearchResult]) {
        let artists = results.filter({
            switch $0 {
            case .artist: return true
            default: return false
            }
        })
        
        let albums = results.filter({
            switch $0 {
            case .album: return true
            default: return false
            }
        })
        
        let tracks = results.filter({
            switch $0 {
            case .track: return true
            default: return false
            }
        })
        
        let playlists = results.filter({
            switch $0 {
            case .playlist: return true
            default: return false
            }
        })
        
        switch section {
        case .artist:
            self.sections = [
                SearchSection(title: "Artists", results: artists),
            ]
            break
            
        case .album:
            self.sections = [
                SearchSection(title: "Albums", results: albums),
            ]
            break
            
        case .track:
            self.sections = [
                SearchSection(title: "Tracks", results: tracks),
            ]
            break
            
        case .playlist:
            self.sections = [
                SearchSection(title: "Playlists", results: playlists),
            ]
            break

        case .all:
            self.sections = [
                SearchSection(title: "Artists", results: artists),
                SearchSection(title: "Albums", results: albums),
                SearchSection(title: "Tracks", results: tracks),
                SearchSection(title: "Playlists", results: playlists),
            ]
            break
        }
        
        customView.mainTableView.isHidden = results.isEmpty
        customView.mainTableView.reloadData()
    }
}

//MARK: - SearchViewDelegate
extension SearchViewController: SearchViewDelegate {
    func searchView(_ view: SearchView, didTapCloseButton button: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query = customView.searchView.text ?? ""
        
        
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    self.searchResults = results
                    self.fetchSearchResults(for: .all, with: results)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
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
        if currentSection == .all {
            return sections.count
        } else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))

        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.frame.width - 30, height: 20))
        label.text = sections[section].title
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor.white
        headerView.addSubview(label)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = sections[indexPath.section].results[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else {
            fatalError("Error")
        }
        cell.delegate = self
        
        switch result {
        case .artist(let model):
            if currentSection == .all || currentSection == .artist {
                if model.name != "" {
                    cell.titleLabel.text = model.name
                    cell.subTitleLabel.text = ""
                } else {
                    cell.titleLabel.text = "No title"
                }
            } else {
                break
            }
        case .album(let model):
            if currentSection == .all || currentSection == .album {
                if model.name != "" {
                    cell.titleLabel.text = model.name
                    cell.subTitleLabel.text = model.artists[0].name
                } else {
                    cell.titleLabel.text = "No title"
                }
            } else {
                break
            }
        case .track(let model):
            if currentSection == .all || currentSection == .track {
                if model.name != "" {
                    cell.titleLabel.text = model.name
                    cell.subTitleLabel.text = model.artists[0].name
                } else {
                    cell.titleLabel.text = "No title"
                }
            } else {
                break
            }
        case .playlist(let model):
            if currentSection == .all || currentSection == .playlist {
                if model.name != "" {
                    cell.titleLabel.text = model.name
                } else {
                    cell.titleLabel.text = "No title"
                }
            } else {
                break
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let result = sections[indexPath.section].results[indexPath.row]
        
        switch result {
        case .artist(let model):
            break
        case .album(let model):
            let albumId = model.id
            APICaller.shared.getAlbum(with: albumId) { result in
                switch result {
                case .success(let album):
                    DispatchQueue.main.async {
                        let targetVC = AlbumOnlyViewController(album: album)
                        targetVC.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(targetVC, animated: true)
                    }
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            break
        case .track(let model):
            let track = model
            PlaybackManager.shared.startPlayback(from: self, track: track)
            break
        case .playlist(let model):
            break
        }
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
            currentSection = .all
            fetchSearchResults(for: currentSection, with: searchResults)
        case 1:
            currentSection = .artist
            fetchSearchResults(for: currentSection, with: searchResults)
        case 2:
            currentSection = .album
            fetchSearchResults(for: currentSection, with: searchResults)
        case 3:
            currentSection = .track
            fetchSearchResults(for: currentSection, with: searchResults)
        case 4:
            currentSection = .playlist
            fetchSearchResults(for: currentSection, with: searchResults)
        default:
            return
        }
    }
}
