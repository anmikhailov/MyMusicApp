//
//  FavoritesViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 30.06.2023.
//

import UIKit

class FavoritesViewController: BaseViewController, FavoritesViewInput {
    
    var favoritesView = FavoritesView()
    var output: FavoritesViewOutput!
    
    var favoritesItems: [String] = []
    
    //MARK: - Life cycles
    override func loadView() {
        super.loadView()
        
        view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Resources.Strings.NavBar.favorites
        
        favoritesView.favoritesTableView.dataSource = self
        favoritesView.favoritesTableView.delegate = self
        
        output.requestDataForTableView()
    }
    
    //MARK: - Input
    func fillDataForTableView(with inputArray: [String]) {
        favoritesItems = inputArray
    }
}

//MARK: - TableView methods extension
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = favoritesItems[indexPath.row]
        let subtitle = favoritesItems[indexPath.row]
        let image = UIImage(named: "AppIcon")
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MusicItemTableViewCell",
                                                       for: indexPath) as? MusicItemTableViewCell
        else {
            fatalError("Error")
        }
        
        cell.cellConfigure(with: image, title: title, subtitle: subtitle)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            self.favoritesItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
